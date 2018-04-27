Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqb+ng4yFnF+nW90eoTD32tHnsDYV0vpsVkKLsGi21IPTxSmMeMGmeScVdUdAzMUR1wijwA
ARC-Seal: i=1; a=rsa-sha256; t=1524837674; cv=none;
        d=google.com; s=arc-20160816;
        b=Fe4RbdOMRoH9GV1f0n+KBobiKfF7V6Vh20WNv4R7r9myYU2Tn3u2riOhit27iGpZLV
         qSvFwPK/pzq1LpJO6Fm+GSpjDpz1BBuXXu1jkE+TiS4IhR0zb64poYwPi/wg1zPAElRn
         svLICLeZgmcEHeAlZJJfW1+ThFVNCvzZJRkdaH2eiVYrX7yoEITLfpNzD4jitBL8WuSZ
         inQf3dCnsr2I7Sdvy3wUrLcwDM4mCl9zs9zuTjCtdY8CrayoKpBiGJBlh80pP1m1Fr8f
         AGaVuoArWnLNsSZtX60iPw4ueCXiKeA4Fwnf47EfsFkjM2Ocl7hsSscc2P5lASbOGn/7
         d1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=p2VFOG1e8YmOPBM2BL6bi1rCbUlmIDqL0Gf+tkFcPVk=;
        b=M/HG9o4KNRfZzZsCP4Igwtp5KeH0FOZqbro48dNJ8q14eCXIcV5vSExgFqa3THp1tE
         p/VWT7zTcdphbYj095bFPWLBXkol3du/JT++6MsUTlaTxwjJiKgUWOhXYKZlniROBxoB
         muNj3L5YdODoWFbjSL8lGYGZ+2uFuwWZl5Qtrxz/9rxXyEmA4MVyCG+Os4u0rBva8GyH
         oh3lOsTv6/LunLaPHWDAN3+EW2vq/jCNKqywuagN+1ycosWod5pMPJJC3j3pQ5kXmgtN
         mUc2GQ4X4ySsY5qJxQt5/2DKSqOwDs4XKqjBKciTFnVPkvzk0hEpdP72hJMArGDodWy0
         30Jw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B538F2185A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 24/50] s390: report spectre mitigation via syslog
Date: Fri, 27 Apr 2018 15:58:26 +0200
Message-Id: <20180427135657.143654571@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908189377552235?=
X-GMAIL-MSGID: =?utf-8?q?1598908189377552235?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit bc035599718412cfba9249aa713f90ef13f13ee9 ]

Add a boot message if either of the spectre defenses is active.
The message is
    "Spectre V2 mitigation: execute trampolines."
or  "Spectre V2 mitigation: limited branch prediction."

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/nospec-branch.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -33,6 +33,16 @@ static int __init nospec_setup_early(cha
 }
 early_param("nospec", nospec_setup_early);
 
+static int __init nospec_report(void)
+{
+	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable)
+		pr_info("Spectre V2 mitigation: execute trampolines.\n");
+	if (__test_facility(82, S390_lowcore.alt_stfle_fac_list))
+		pr_info("Spectre V2 mitigation: limited branch prediction.\n");
+	return 0;
+}
+arch_initcall(nospec_report);
+
 #ifdef CONFIG_EXPOLINE
 
 int nospec_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
