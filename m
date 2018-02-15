Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226SjC9LngccMICATQNsqYL9dohVNBFuwa0+hZSOPtbgjpmXhvgiOuItR/GuNtCrqcgP00W4
ARC-Seal: i=1; a=rsa-sha256; t=1518708152; cv=none;
        d=google.com; s=arc-20160816;
        b=gFEPVMHXHCyjeiTsk2ReEJs5bDQ1bRbCQNuNwhR5IUuv/UGvgbZviwW1GyFjpGcekf
         dhjUJWCNc8oR7VrapAY0YHzM7NTzUB/+TzjuhNeBuhhn4XPTbLTlWFFdeY9FuLmIkULy
         MLipEZC9JHdKGpZQaescRP9lKE1ZWq2A0sOU8uvJMibN3SZME3xGIL3bH9KfA9rm8JI2
         02PVTXuV/nPNuV/A+5yUiYQw5xcp+PGVbM6F0FxTzdNN6K8ZV7dDvVhvDOFYN8JwWCUh
         +anmuFNB0R4YFC+HF5IOiCRuutDQYhyWHRf2YmWZZgUytDTeVe/+VAIHMt4wfGMtrDju
         c0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jK1SVSqlWJ3rsywLi0YF2Jvy9aeFlx+mYXvInwEfl8E=;
        b=STO9o5APklX99CD4Su7MqT/n2rr4U2xDdDEXkembiWgMeGpRwYHOC/GtLKBAV1m3Ir
         WV4hr/mIwrAkect4hrxiVBeY+uRrUu9AXAWN52fqnc7cUxspaFhfzTndu7EG2OX671qN
         5Evb1zxbaHfLZfL9pP9SwQXBpSz7I9rmvLEHFEMtzQVUPRZ/RhZ4Wcrb2b0ESVX9EQf2
         qSSCdjpTUIy+N+mBx4nK/gAxzyKIz7tI1nAxsXlfI3in1dx/ELHlhL46D7n6MGftneV+
         lvDtFp2+MKIMCZ2z7n+9vzLOFAs0ubrN1Egy1gZ8AW5FNYIsvAPXrk0O3whdtKKsssnz
         RDmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH 4.4 044/108] x86/kaiser: fix build error with KASAN && !FUNCTION_GRAPH_TRACER
Date: Thu, 15 Feb 2018 16:16:41 +0100
Message-Id: <20180215151228.588670677@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480920000477734?=
X-GMAIL-MSGID: =?utf-8?q?1592480920000477734?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

This is a build fix for the 4.4 PTI backport.  4.4 kernels do not have
commit be7635e7287e ("arch, ftrace: for KASAN put hard/soft IRQ entries
into separate sections") which went into 4.6.  Consequently, the
irqentry sections are only created when CONFIG_FUNCTION_GRAPH_TRACER is
enabled, not also when CONFIG_KASAN is enabled.  Therefore, fix the
condition for trying to add a user mapping for this section.

This fixes the following build error:

    arch/x86/mm/kaiser.c: In function ‘kaiser_init’:
    arch/x86/mm/kaiser.c:367:33: error: ‘__irqentry_text_start’ undeclared (first use in this function)
      kaiser_add_user_map_ptrs_early(__irqentry_text_start,
    [...]

Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/kaiser.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -363,7 +363,7 @@ void __init kaiser_init(void)
 	kaiser_add_user_map_ptrs_early(__entry_text_start, __entry_text_end,
 				       __PAGE_KERNEL_RX);
 
-#if defined(CONFIG_FUNCTION_GRAPH_TRACER) || defined(CONFIG_KASAN)
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	kaiser_add_user_map_ptrs_early(__irqentry_text_start,
 				       __irqentry_text_end,
 				       __PAGE_KERNEL_RX);
