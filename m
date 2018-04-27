Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqmNcNBLcImvcqDFF+IOywafVBIatKmvpmD5MRhUiD+P+po3ER1/a48Aq9svRXyxQxG/74t
ARC-Seal: i=1; a=rsa-sha256; t=1524837861; cv=none;
        d=google.com; s=arc-20160816;
        b=0oqkWWu6W6Aq4OwkorKlJt02Yd5TN00AOnnbECm9L3VmKm6HLRMnkDPtXxnyyLaevx
         XglaWsv0BJFwEnf6K6EpJDgRDyR6Ietrw4WfzP4HZSlAxSvCT/NRD1YhviBMWcUptHnm
         PBhYGbwssXES9VUqcWrreTOD7u5JFhpKugJQ9JVQfYGIWDNcjg8OpYKOh2QqGYIZldX6
         XUlHmKmRY8tvAusQ2TmdTtXf/Ro4XFRfhwuMM7XTxdtNzViNHQ/3Vl2aVrm9cdgHoc13
         54lwFI3bH0Wa4Ew43bXyPyaIA0Catc4/Tl9tCd/hP9p9ROISnN1OUFEtzhAidkm1J+vc
         9/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=6gIbnU/oaLQUWjfc2pn+JEWwJl0KEFif0bwpUAEzsO8=;
        b=DaHR2Zf7267mTUBu/AOlsqMI2bsf+78sbH3rbB9KMGhzzOaJ6th4FEgG1M4oDg3dI8
         ic4CBzwG2u6ihIGhzuHgIRwc+Aan/XUbW3VSv4fKW/DIR1lL+d8tApG9u3FRTwULpgBd
         ByF6PkwKfm+stGMszeKbcV62UHB3y3e5ncrk0mKWpQ3UlUzgOx6uLbzIytxt3B4bGEG0
         K2vdphp/+oFW2apOWTqHpPWGeqeDkulmNxVy3ZB8mByrVYFhZt7NQDNuS/m+TwpvQV16
         Rgs+D7ZJeigRiBUw+SrsCs1dqeaMHk2/bjUuk6JR7KcMT+2ag0gvkq6e734bLh/UsypS
         tZaw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D2D2189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 43/74] s390: report spectre mitigation via syslog
Date: Fri, 27 Apr 2018 15:58:33 +0200
Message-Id: <20180427135711.710333929@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908189377552235?=
X-GMAIL-MSGID: =?utf-8?q?1598908385376567031?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
