Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225N02c+czMfUdk0iNQ44S2n7k7GLQntZ6O7Hn4KOjoiEztPFYLYxXZHwHlGwRzxmOwiinhU
ARC-Seal: i=1; a=rsa-sha256; t=1518709320; cv=none;
        d=google.com; s=arc-20160816;
        b=e+sT7GrlGDfoTGNsw1OO+W3LeTfvqBx6lY/H8uUOrw20zfG6QCtclxWRIdZ3I9aUFQ
         1vKYHFwiA3iWNIYtovRaFGZUnHfNCfJMprjc+CLNFRr3qjpjYrOXPsn0LsAMbx4mk+Du
         59tOe6gzqGzcfo0ddDfJhcjTlqbEvWqBItfCykFXjrdrQyj6xZBxUTpzdoeSPkUFKtLM
         q+Q2x5M6/g1H2iA3FeNiPtMhJPGhb1iIb+WWmMIo+EwagOAWkrA1ceORSKgQUB++vJ5I
         fhiqeWslTG6EuZdcU2wVqJN7cZc19n/PQqpjynxU7Yz4Py0k8q8uFKL5adZ9kOnDWx/+
         rOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yCjEHzlI0Ds7zuQv0aTlwwXbx46DKcdqUk6OS2cE4uQ=;
        b=cBPPuTq6Ek3RvaIpXME0YD85jPzQupPr4j6Ec1G+w3Q7Cx5GUUAZoT3yH3JRPPKLa1
         OQbHJTNbgYPXOmZxqhR2PNJx5Mh7KfamrXF6HFw7hWgGbWCBi7vDzMXZ5MT10smPFD1/
         ldFrxFdNCFQJBdAdE/uVQ6tcv4STWwY+oixKB0zu77RhvrDJlbHxt6+wpdpU1bCo3nMj
         cH3FU2Op3NkMNtHpQZ6KIiv+i7O5wfcc0fvFwBfJqCcg/S06isAg/LxNfkwX1ksINAba
         jbUZwlAA78uoJkqp/yT5aNccV6vfvjzF8WYq8WCZ9v2Qmy+Z7ai7UGpsHQ88GjBXDK2W
         rglA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 048/202] [Variant 3/Meltdown] perf: arm_spe: Fail device probe when arm64_kernel_unmapped_at_el0()
Date: Thu, 15 Feb 2018 16:15:48 +0100
Message-Id: <20180215151715.725606175@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592482144428725297?=
X-GMAIL-MSGID: =?utf-8?q?1592482144428725297?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 7a4a0c1555b8 upstream.

When running with the kernel unmapped whilst at EL0, the virtually-addressed
SPE buffer is also unmapped, which can lead to buffer faults if userspace
profiling is enabled and potentially also when writing back kernel samples
unless an expensive drain operation is performed on exception return.

For now, fail the SPE driver probe when arm64_kernel_unmapped_at_el0().

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/perf/arm_spe_pmu.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1164,6 +1164,15 @@ static int arm_spe_pmu_device_dt_probe(s
 	struct arm_spe_pmu *spe_pmu;
 	struct device *dev = &pdev->dev;
 
+	/*
+	 * If kernelspace is unmapped when running at EL0, then the SPE
+	 * buffer will fault and prematurely terminate the AUX session.
+	 */
+	if (arm64_kernel_unmapped_at_el0()) {
+		dev_warn_once(dev, "profiling buffer inaccessible. Try passing \"kpti=off\" on the kernel command line\n");
+		return -EPERM;
+	}
+
 	spe_pmu = devm_kzalloc(dev, sizeof(*spe_pmu), GFP_KERNEL);
 	if (!spe_pmu) {
 		dev_err(dev, "failed to allocate spe_pmu\n");
