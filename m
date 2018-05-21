Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpXruww/l7zj2EwBrMWfqXq7Yrj6Xb+zRrQpuAk0JDdJcuDD0ppzwoysXB0dAA76M/W1NFu
ARC-Seal: i=1; a=rsa-sha256; t=1526937306; cv=none;
        d=google.com; s=arc-20160816;
        b=mB86cxKbYGEvHbdGzbWJqwazklXdYDXo7JWPhxn3yxl59xtxS4kKEtC2a3S6wo0ejy
         mxZXjm9Osac6qbgfSl8DJW/bRI4BwQuEklv9NUFiVAFSvDXDAxjsQo8b6FD9XH1OHg1A
         ZIAXFzicoHI2AvSIEv09EeEPaat5Dag2MlgogDtMswr36HSH8aW4uTFIh4K40QeB/D9i
         dp2lvnIZenEkh8GYFrELCvutj/530XDD2lfxPALHbp/1NedBXTh10NSw3+DRjesYCIq1
         iBwITPLc9eGUv1HGv686RdaMuoQTDgjWU05AO3dHtaAnscAmVUlkcY9qVUqPx4DJBF0i
         t3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=yvrbbGee7JkF8TooSs8rQMj7c2ugwWaoldxP73KWorE=;
        b=rZihh0DmEU7vDOUNpI04wkdsM8jpklSzERI1+A0iOkIcwg9YdzLkjgnG3XgSDQuisO
         5k5Q3KcEFYZHrpaEaUztWeZtsYITpZxncsI3ITJJYCfBPMAIEo6sI2NHLpuveVJgMz5r
         NQ5tdZaGq9t3PAgz/5MM19MNGPQuJ5jv6Pd7a21ifXSxx3yuGd7/18VDYps9qNWjf20D
         g3QSUehzAoUkCUPgcwiMIC1MZcyhb4xDsI2VhGAYwHutp5zB5zPdjha6b2w/cNmPVF45
         0rMnlxfv4skHSUmuEhractBYQmrCOYlrU944kKni5w8nbw1UuulFxgr3WKMk6w1/e2u8
         FyJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sFbTZIhV;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sFbTZIhV;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 34/87] x86/amd: dont set X86_BUG_SYSRET_SS_ATTRS when running under Xen
Date: Mon, 21 May 2018 23:11:10 +0200
Message-Id: <20180521210423.609407739@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109813034580646?=
X-GMAIL-MSGID: =?utf-8?q?1601109813034580646?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

commit def9331a12977770cc6132d79f8e6565871e8e38 upstream

When running as Xen pv guest X86_BUG_SYSRET_SS_ATTRS must not be set
on AMD cpus.

This bug/feature bit is kind of special as it will be used very early
when switching threads. Setting the bit and clearing it a little bit
later leaves a critical window where things can go wrong. This time
window has enlarged a little bit by using setup_clear_cpu_cap() instead
of the hypervisor's set_cpu_features callback. It seems this larger
window now makes it rather easy to hit the problem.

The proper solution is to never set the bit in case of Xen.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/amd.c |    5 +++--
 arch/x86/xen/enlighten.c  |    4 +---
 2 files changed, 4 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -824,8 +824,9 @@ static void init_amd(struct cpuinfo_x86
 		if (cpu_has(c, X86_FEATURE_3DNOW) || cpu_has(c, X86_FEATURE_LM))
 			set_cpu_cap(c, X86_FEATURE_3DNOWPREFETCH);
 
-	/* AMD CPUs don't reset SS attributes on SYSRET */
-	set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
+	/* AMD CPUs don't reset SS attributes on SYSRET, Xen does. */
+	if (!cpu_has(c, X86_FEATURE_XENPV))
+		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
 }
 
 #ifdef CONFIG_X86_32
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1977,10 +1977,8 @@ EXPORT_SYMBOL_GPL(xen_hvm_need_lapic);
 
 static void xen_set_cpu_features(struct cpuinfo_x86 *c)
 {
-	if (xen_pv_domain()) {
-		clear_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
+	if (xen_pv_domain())
 		set_cpu_cap(c, X86_FEATURE_XENPV);
-	}
 }
 
 static void xen_pin_vcpu(int cpu)
