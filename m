Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoowRbePfxdj4wVTo6aBdvRv0kK0sM/7qFs3UzgM2fhzjSoR1qpSBhdyvVpwLenEl95seJy
ARC-Seal: i=1; a=rsa-sha256; t=1524837664; cv=none;
        d=google.com; s=arc-20160816;
        b=lkI929vHDTzYtduYLT35czV0nQV5dZ7LD4O4OMDpzGzQgEfiiSLIpWo/l7f2RFbj8b
         HvAEzl7MRNvfnw/FtdjZNOVzN70S+CitFaawR/p1gUwOzoVjRcheBSbEyYIlXEkOK8DW
         YMypdDjr0MBhDq6u9vRuUZhEzUwcv4pM8//XKNBfJKtTl5qSoIaXzvv4Ppy5PsNy6+OP
         Hpju5toRiiHhBWVhXZG8jUrr7MG8m5rYjFsxPR7aTDkzVoMeIDa36Jbgf0I/h0JuM0IG
         anUDny7Dvb5TXkbMWGPo/2mf1U69sZ25kpPQTAO/U+zhHPn7Z8nu1mA21RMCEyTZsSJP
         utgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Z7Zkd6UpUQud6wTNV89RyO7Sjqm7jGuD8790w8REZtI=;
        b=FYDbN8bwFnfCtEpFNwtRLbqWu+w1f8fgUB81Tyc84GjP7eRubnMNuo4t9PtIkSykoa
         zV6NP4Vv70vkl9byJzR8/BzR70mF3pniAET4oLWzltxhg3FKSApzoCtsfY9nMUvT+IAB
         vZJR0pH2kN6my6hMKWDgbuW7VwxTVNxP8pF62M7alaWos8ycbI8ex+MhhHqZ4WqdcJXG
         5hl5ZrYFGyzEo3NDJ4vDYRZCYP+aQlLSzdbnUjFv1Gfby6YMaJvh6xy7FUCEg1hw/nF+
         GGFdUG55Bf9egWIgSxDJI7Eu0Iub/l+9i3t3b9hDYBvd6tce/wq9CGTKSbsmwSgsaoiG
         9XIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC2A2185A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 20/50] s390: do not bypass BPENTER for interrupt system calls
Date: Fri, 27 Apr 2018 15:58:22 +0200
Message-Id: <20180427135656.906980609@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908178667353015?=
X-GMAIL-MSGID: =?utf-8?q?1598908178667353015?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit d5feec04fe578c8dbd9e2e1439afc2f0af761ed4 ]

The system call path can be interrupted before the switch back to the
standard branch prediction with BPENTER has been done. The critical
section cleanup code skips forward to .Lsysc_do_svc and bypasses the
BPENTER. In this case the kernel and all subsequent code will run with
the limited branch prediction.

Fixes: eacf67eb9b32 ("s390: run user space and KVM guests with modified branch prediction")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/entry.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -1299,7 +1299,8 @@ cleanup_critical:
 	srag	%r9,%r9,23
 	jz	0f
 	mvc	__TI_last_break(8,%r12),16(%r11)
-0:	# set up saved register r11
+0:	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
+	# set up saved register r11
 	lg	%r15,__LC_KERNEL_STACK
 	la	%r9,STACK_FRAME_OVERHEAD(%r15)
 	stg	%r9,24(%r11)		# r11 pt_regs pointer
