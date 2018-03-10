Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsKZEqPcBgwQSiuTb3FVuwB/z31xDx4vmUmXm9tDK/Uyqoyt+94fZMaEkKi3M5XYjwhtGBA
ARC-Seal: i=1; a=rsa-sha256; t=1520641388; cv=none;
        d=google.com; s=arc-20160816;
        b=kAqAjEtyjqhGNKCD5iC4l+hEYdidTpnY/HpzBPqgev5rEF7S04j1VHjIoo0fAiYvt1
         nnXP++W++6EimOmCLpPm/OujmKLwDR7d0/IyS1OJKtFOcsI7kKwm7e34tujL1OkcqNpm
         d/p4+JBLaDHL/KwMOjU9qLEXbs4pEEEw0FcFP2LnyoERbcD9OWOSGAWO7l3xu7iiiHPI
         UZrsJyzbzJHCFuNWwF3fumj4TgkDUohRjFM2WVZYRvmVtYTqlqBKptp8GoiihrW4M0z8
         uU+vmbCGtHpMQSalNzk2WO3tHZt9m/0F4q4QkfvX1pz4ZUouwWBJV58J7nD5RPQFdi/y
         +CuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9kRH7/ErWT5DJn23ZrTrsX2LUVqvfFfwYWAgDAN1RBE=;
        b=a6kOWTI0+AYFBcTyPwIPGqCUQFb5ClwJoQe805sXBqvOgO+MTQvKPqKIgFNBeH5Szt
         YxQATpPhYKcOnVEKsil7t6g3oyMtsG0ISd/3cE9Md5PhyUeBF20TFHoq/q6S7WlUO3OI
         Jo0PXnscman3gB2vH0aT7uahq49Uf5Lig6jBW7yvkCol8TqWF87uWhK3irfsWP73+zwN
         ZS3JgV8BuCOOUL5kNCUFzdec6lzLw8N0yLqqDXJPcATCwXAvpukSB0JwjB8PgXcVjCwf
         Y4nRNCyINzSM+QmNKyeiwIMn0QawHkpFwAQhe23gSJMhgwsvpysUfPAjKakTjF7Cl92j
         qsCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"ast@kernel.org, daniel@iogearbox.net, stable@vger.kernel.org, Eric Dumazet" <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH 4.9 63/65] bpf: add schedule points in percpu arrays management
Date: Fri,  9 Mar 2018 16:19:03 -0800
Message-Id: <20180310001830.358238552@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508064309935439?=
X-GMAIL-MSGID: =?utf-8?q?1594508064309935439?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ upstream commit 32fff239de37ef226d5b66329dd133f64d63b22d ]

syszbot managed to trigger RCU detected stalls in
bpf_array_free_percpu()

It takes time to allocate a huge percpu map, but even more time to free
it.

Since we run in process context, use cond_resched() to yield cpu if
needed.

Fixes: a10423b87a7e ("bpf: introduce BPF_MAP_TYPE_PERCPU_ARRAY map")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/arraymap.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -20,8 +20,10 @@ static void bpf_array_free_percpu(struct
 {
 	int i;
 
-	for (i = 0; i < array->map.max_entries; i++)
+	for (i = 0; i < array->map.max_entries; i++) {
 		free_percpu(array->pptrs[i]);
+		cond_resched();
+	}
 }
 
 static int bpf_array_alloc_percpu(struct bpf_array *array)
@@ -37,6 +39,7 @@ static int bpf_array_alloc_percpu(struct
 			return -ENOMEM;
 		}
 		array->pptrs[i] = ptr;
+		cond_resched();
 	}
 
 	return 0;
