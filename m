Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Ihyo89lm5m7JAtzoX3BzTmZFdvgn9b6SxUXlTnWkkcmIFDnBqlFEgSdFPQd9cxX3srFDF
ARC-Seal: i=1; a=rsa-sha256; t=1519218435; cv=none;
        d=google.com; s=arc-20160816;
        b=x88dszvaqFl3auKTv28K1w7/8s1vwH+AQBzMYoxY0QwUOoamypPOUBoCekEqi6uKmJ
         amD5EY1vbpR4cEs7daWZY8Z3XGRu0GRFuTYp3YGx0NcFkgl/MskPyI6ESEJ3sNYbAOxB
         YNBUeCV8NcuxB2K/cfyNXoyZzrmI9MpVMaK1WDiaIMvZWgjLT5gh7aCAty8Moq05lROl
         6gUYn78GB1WnGCym/dNPg/8aymoFZvdvo/nF/ksEFLtISj+dh7Mxh6rV+RV6DujaESWu
         AAr7In3cQy5ANDNbCNsN0pQisyJrAQ4XbwNv23LIdvSk4MAhlobsRWklwwszh8TgKSfm
         5o9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=X5+jZ8ux7VwneS6nifT0nnUT5nyYBIzAgyMQ7357i/U=;
        b=MT9Y9CdcvKcTFSOjMms0R4UbweLUuUu8XNP3ackL9T8haWPOQqADAZGvY9n4Wov5pK
         bkzY84B8cOzON7FXPBHky0MJ4nTlDzsYzMfwuzbphLlrEm1GOOknIjJIOEWgwjlToz56
         y0MlHSkxA7h8KxSvJQnvfssm5NitnrTmvURmwWIunIxGRLGtJHECNk1qB9oaP6NK7Dhr
         bHDaa5wSMIoNLSH4796uDS+F1H+MqTj/vVG3+uMM+VJqFW65Xu4flMyUKs+sB+U9oDUR
         kjaiMFoLpHyvkjHbnP35VBBJFXHbkFrK2O9UMNh7yvVurTaK3M2yDZ2+Yy54OrMxLLN5
         oNAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.15 038/163] x86: PM: Make APM idle driver initialize polling state
Date: Wed, 21 Feb 2018 13:47:47 +0100
Message-Id: <20180221124532.431052908@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015610134726356?=
X-GMAIL-MSGID: =?utf-8?q?1593015990564532632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit f859422075165e32c00c8d75d63f300015cc07ae upstream.

Update the APM driver overlooked by commit 1b39e3f813b4 (cpuidle: Make
drivers initialize polling state) to initialize the polling state like
the other cpuidle drivers modified by that commit to prevent cpuidle
from crashing.

Fixes: 1b39e3f813b4 (cpuidle: Make drivers initialize polling state)
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: 4.14+ <stable@vger.kernel.org> # 4.14+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/apm_32.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -2389,6 +2389,7 @@ static int __init apm_init(void)
 	if (HZ != 100)
 		idle_period = (idle_period * HZ) / 100;
 	if (idle_threshold < 100) {
+		cpuidle_poll_state_init(&apm_idle_driver);
 		if (!cpuidle_register_driver(&apm_idle_driver))
 			if (cpuidle_register_device(&apm_cpuidle_device))
 				cpuidle_unregister_driver(&apm_idle_driver);
