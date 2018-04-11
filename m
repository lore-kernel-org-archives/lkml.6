Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/9Sq0+ROA9wRXtNQ3aURZWO4Smi2YiA3AqjrUy9Edey174Uicbgf28aTtwK7AT3eZIDx8G
ARC-Seal: i=1; a=rsa-sha256; t=1523472986; cv=none;
        d=google.com; s=arc-20160816;
        b=ZzFniNwC9Sq7JRLxpRXOB3y8dXPBMRBL2h4wPnxyqhTtK/NV4300rpTCqkZv+IKYTZ
         sx6Vs55R3oi0BErSAfKZ2ABsghIv7yEbJBfQielbrYOO/6uF+ugxo3KOOHzutDqiRNPt
         6jB09K3Cqu21OwMZ7JoaR8HMFdEcek6rkbVcD8ZvVYERHl3PQZ7Ghd1Sbjj/z3i+j/iW
         B+nqYaJ6V0z+gQ7z7OGpN6Ek9T4XiSlKN1zBvdqjt8b3F0bP44G0/GWp0WRHv1LeU8hW
         /ihFFgvAJDIs8O4wQway1NmFbQZpOKEU4ni6XR3lWsirogbPfhZ6Khb5h9lKqKw8d6AN
         276A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IhG23R68S+TAW+7pRTVb/u752CFFJ0QlXnIF+pBjAN0=;
        b=fiVDRcPqodVjGxkCcpoNeNk/kF2hJtpjVLJWiq+e1Rmy+Efyz25yVKQ8GLmDvRXn/I
         MOEqx3QPXy/zQVmiAC8qw0NSBYQm+O5yYJHF6LkI0vO7NaVVBkUco32wJEm/XjAfEE10
         CQRkjWeYMwXQZ6XN7G+ZcePZhYlaapAq7xjushFMxk3E/pyyUZ00drgfiSgSTQSl3KQW
         sKOdPXnfif5hHfh7NxvLphlIYxD4I7R4S3Ig5SIH7SRbIUSor/aB+cCOk4FMckulOLJh
         jnLdCghL6rOQ0868NL69CpCVA9QedQL4mL3qHdqA0xfi7EI6jg8IxZEmAFdF7H3P/P/B
         EHDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Suman Anna <s-anna@ti.com>,
	Sekhar Nori <nsekhar@ti.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 088/310] ARM: davinci: da8xx: Create DSP device only when assigned memory
Date: Wed, 11 Apr 2018 20:33:47 +0200
Message-Id: <20180411183626.046206223@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476129126751968?=
X-GMAIL-MSGID: =?utf-8?q?1597477210537908751?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suman Anna <s-anna@ti.com>


[ Upstream commit f97f03578b997a8ec2b9bc4928f958a865137268 ]

The DSP device on Davinci platforms does not have an MMU and requires
specific DDR memory to boot. This memory is reserved using the rproc_mem
kernel boot parameter and is assigned to the device on non-DT boots.
The remoteproc core uses the DMA API and so will fall back to assigning
random memory if this memory is not assigned to the device, but the DSP
remote processor boot will not be successful in such cases. So, check
that memory has been reserved and assigned to the device specifically
before even creating the DSP device.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-davinci/devices-da8xx.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -821,6 +821,8 @@ static struct platform_device da8xx_dsp
 	.resource	= da8xx_rproc_resources,
 };
 
+static bool rproc_mem_inited __initdata;
+
 #if IS_ENABLED(CONFIG_DA8XX_REMOTEPROC)
 
 static phys_addr_t rproc_base __initdata;
@@ -859,6 +861,8 @@ void __init da8xx_rproc_reserve_cma(void
 	ret = dma_declare_contiguous(&da8xx_dsp.dev, rproc_size, rproc_base, 0);
 	if (ret)
 		pr_err("%s: dma_declare_contiguous failed %d\n", __func__, ret);
+	else
+		rproc_mem_inited = true;
 }
 
 #else
@@ -873,6 +877,12 @@ int __init da8xx_register_rproc(void)
 {
 	int ret;
 
+	if (!rproc_mem_inited) {
+		pr_warn("%s: memory not reserved for DSP, not registering DSP device\n",
+			__func__);
+		return -ENOMEM;
+	}
+
 	ret = platform_device_register(&da8xx_dsp);
 	if (ret)
 		pr_err("%s: can't register DSP device: %d\n", __func__, ret);
