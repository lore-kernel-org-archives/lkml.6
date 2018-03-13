Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtBubcNdbCyqHks1A76CWOFeHCzjSMHbiDJ9bGiJtNseEixVw2N3YnzObIkImeVpXH+ME/v
ARC-Seal: i=1; a=rsa-sha256; t=1520954876; cv=none;
        d=google.com; s=arc-20160816;
        b=y7xh7K1NFjp2IWF9k3L6P9WQyuQB7g0LKrIpV5IHyLd6HkX/wda7lOt4LIIjHO13e1
         TAF8H1nEVAtlbK5443JH76ejUQaoPIjcAFbcsgt9r/rXavsJz0pS0zJ0wJWce5BuzfFr
         8qTv5fr/tOpuLcYnX/J1w7Q/P34+1uj5Vyw2eOBilGeTzBW/9P7/tpolTw67zbznVO07
         NnLV0coCYKmBspucZ16cC8yb5jX+JHqdtWuFoIbp6EY8O4NFRCaKzC6r3QdpAjVgqpMY
         bTPbEXcPb/XN2ymhL7fxD7YnJmC91N+0tE1KmKMs3+DOw6YtDBwsaVMxBtQklEzlVtqn
         qvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TojmPEh5v2xCQkRUEtBNTbYN1Ekm4dT7fwUYW6rZqx0=;
        b=UY9ncJwSm2YLHMTouD57F2k0PWzZWAPDDzneYrv9IUjDv6TBeQvd8lgbvYWbm6vyCK
         n6AC1z5AiugFyoE0gkLfFxtC92l+H+PPDp9Tf/nxgd7C7pWZsAXnzT8vUg6QxKHFwziQ
         qfWuBrxV9tw3rKPvcmhKGktZHmOynKURdj79Vw2FwHTszmnoAozsYDGDkKkZbgeAVril
         Il1G+qowVjfaPyVdyQ3k1Vi/wjP8Y/pSgLlLy3F7Lgf+JV3kk/vmKt4uMQY8RYI/SYhW
         ku5LQicc/CXAXkjrJtRmHfyZIJdPd2J4IY+dGGksMhEM0LHHkKBwbfedjwEcDXGuVxTX
         cqTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+1a240cdb1f4cc88819df@syzkaller.appspotmail.com,
	Michal Hocko <mhocko@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Matthew Wilcox <willy@infradead.org>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	akpm@linux-foundation.org,
	dhowells@redhat.com,
	hannes@cmpxchg.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH 4.15 004/146] bpf: cpumap: use GFP_KERNEL instead of GFP_ATOMIC in __cpu_map_entry_alloc()
Date: Tue, 13 Mar 2018 16:22:51 +0100
Message-Id: <20180313152320.932915953@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836781464887360?=
X-GMAIL-MSGID: =?utf-8?q?1594836781464887360?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

commit 7fc17e909edfb9bf421ee04e981d3d474175c7c7 upstream.

There're several implications after commit 0bf7800f1799 ("ptr_ring:
try vmalloc() when kmalloc() fails") with the using of vmalloc() since
can't allow GFP_ATOMIC but mandate GFP_KERNEL. This will lead a WARN
since cpumap try to call with GFP_ATOMIC. Fortunately, entry
allocation of cpumap can only be done through syscall path which means
GFP_ATOMIC is not necessary, so fixing this by replacing GFP_ATOMIC
with GFP_KERNEL.

Reported-by: syzbot+1a240cdb1f4cc88819df@syzkaller.appspotmail.com
Fixes: 0bf7800f1799 ("ptr_ring: try vmalloc() when kmalloc() fails")
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: akpm@linux-foundation.org
Cc: dhowells@redhat.com
Cc: hannes@cmpxchg.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/cpumap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -339,7 +339,7 @@ static int cpu_map_kthread_run(void *dat
 
 struct bpf_cpu_map_entry *__cpu_map_entry_alloc(u32 qsize, u32 cpu, int map_id)
 {
-	gfp_t gfp = GFP_ATOMIC|__GFP_NOWARN;
+	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
 	struct bpf_cpu_map_entry *rcpu;
 	int numa, err;
 
