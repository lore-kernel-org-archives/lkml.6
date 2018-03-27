Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/8b0dD+3C0S+XE2oLetULdcGe23AUBx+WJCtT+kdxTlNiNdFXZ5YfW8YlR/4sILc5Q9LvF
ARC-Seal: i=1; a=rsa-sha256; t=1522168996; cv=none;
        d=google.com; s=arc-20160816;
        b=jcd9e3MIk1TMC7CWL2m/UKk3SW83uMRsVBIHNfxLjvi0bmw9bGFxZrQAl1v9kIOpDJ
         BMffun8vbx2JYOERoVC9w/UFsADEjwGnGrhKLUou6qXV4RNPMXTkIWGA+eZ7f8eGrwAw
         wFH1aJ4orzpGCV12YTMGZYaqbOdQRVyfV7iuOMM1vbhJM+zyRV0bodWRcEOwtPXi3jBk
         zLRYM3GREYG1g3OXT3sx4gllKmHGN5uHoWnRu9n9icVyUj3tSZFoO00t34rucod/vzLe
         edXRVk7BtgfgTHDNSPMGZptSNbnnVLfBK9L48y9sbKkSq5kLj7lSo1aUha+ng+ITvD8T
         MuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ws/vsbbjo3aNdcZQobQY//o9wITVR0xqxgrZncbI3e8=;
        b=k67Uc76F0+S/QadewluHEr/0DmHejvUfFeCn/1v0lbJ4Jv8N7pgtZcph7hqSvCxRZY
         AraQjCnMlK8D2nzckXGzEhXEQOJDVF9g6JrVqNJ0et1hv8kEMK8QGfWigYXEm+vGKE2A
         b8cMd31B43d5tm3BvE67jRsFOVVbfvSeKudry7v5u76866Dpu44qBLNMl59N2gnm4KKF
         xB31uJJUYqJw5MnAuja7RATrCNXNWNN2kiLmEC49RhtTU3gapiFVlUZgzCIErfSOEvI8
         7wbEgvpXwXAr5NQXoynrl/HCEnGf+LGu+NKMcblbqg4JMH2Wm2+tl3Dm06hu3bFP//EZ
         ykXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chenbo Feng <fengc@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.15 104/105] bpf: skip unnecessary capability check
Date: Tue, 27 Mar 2018 18:28:24 +0200
Message-Id: <20180327162804.245578673@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109077299522415?=
X-GMAIL-MSGID: =?utf-8?q?1596109878055673735?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenbo Feng <fengc@google.com>

commit 0fa4fe85f4724fff89b09741c437cbee9cf8b008 upstream.

The current check statement in BPF syscall will do a capability check
for CAP_SYS_ADMIN before checking sysctl_unprivileged_bpf_disabled. This
code path will trigger unnecessary security hooks on capability checking
and cause false alarms on unprivileged process trying to get CAP_SYS_ADMIN
access. This can be resolved by simply switch the order of the statement
and CAP_SYS_ADMIN is not required anyway if unprivileged bpf syscall is
allowed.

Signed-off-by: Chenbo Feng <fengc@google.com>
Acked-by: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/syscall.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1687,7 +1687,7 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf
 	union bpf_attr attr = {};
 	int err;
 
-	if (!capable(CAP_SYS_ADMIN) && sysctl_unprivileged_bpf_disabled)
+	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	err = check_uarg_tail_zero(uattr, sizeof(attr), size);
