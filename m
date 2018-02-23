Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuSlnRCC91pKHa91Vs1DgMF+J8SN/IkctmxoASjZYVtDUcSvHv76ZRLr5jmvxDWJrrGr5Uv
ARC-Seal: i=1; a=rsa-sha256; t=1519411150; cv=none;
        d=google.com; s=arc-20160816;
        b=RGI1v0zEMCS2Vo88IDlpFRT8ivqCc+7fkVzwfJNOUEMNxRyYt3KkH3wnBtoCrg3V3P
         J+XpCffTn1NhYJomoC/wE6IsiXQpGwL64IF5oL1o1r+PwT9ZTS8r9mhkv1v1TFiOKPTU
         WgDv1/XADe5C20H/fvDXcrrdfCbmb2GJ5t79grht0b49P5Vhbeweit0TndgeEiR5uNHS
         Vkgyl/iEdcuSOOjYa2vL/Xg0/AYndhZBYEwgPEziJmitHBzPsRbHjJoFKU0RRbD6sFHL
         HL4OPe9Wwh1/1y6Vh4+0CusphXB418JG9d0mmq4VYQ819Ay7666FOScNpfQEcpp4mrUf
         /RTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wYTQXOQhzh+nVIa5zV7Foc5OHYdtqdlbimekLHaPGHk=;
        b=1DvhCHn1H0RuqcOeueo1irmL4UJXThQxa1QblpmbvbMGcsE/X0iWLRJZpFMiS8W7Gk
         Y6SExa2agxMwaWKPUL7dyZdlxltvqdnaNvSDcxUziRgjUaAswNRECZiJX5pyeJn3Mb9G
         BpgTf895auWjGDNdqYZgVF+JDKYPT9Djr7H3UL0BOsCm04432hB+GKNlvusbkMXDKjK6
         PEIJGznfo59P+uFlJzvHmpOf5ZuY7a+11fx3GhkoqkZA6Evl2ZvFfDQcFZ+0PxyXvtFG
         RVEhUIgN1HDLoR49tz3V8w2Umtx3l5/pm04Qu/gYjlOxLZz6HK01NcLaUpfP7tdfCOQi
         hNaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	kbuild test robot <fengguang.wu@intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.4 138/193] serial: 8250_mid: fix broken DMA dependency
Date: Fri, 23 Feb 2018 19:26:11 +0100
Message-Id: <20180223170347.404250175@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218067348033263?=
X-GMAIL-MSGID: =?utf-8?q?1593218067348033263?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 0ff4230584320b2153752ba54e2e8edbd6addf2c upstream.

In order to enable HSU DMA PCI driver, the HSU DMA Engine
must be enabled. This add a check for that.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -372,7 +372,7 @@ config SERIAL_8250_MID
 	tristate "Support for serial ports on Intel MID platforms"
 	depends on SERIAL_8250 && PCI
 	select HSU_DMA if SERIAL_8250_DMA
-	select HSU_DMA_PCI if X86_INTEL_MID
+	select HSU_DMA_PCI if (HSU_DMA && X86_INTEL_MID)
 	select RATIONAL
 	help
 	  Selecting this option will enable handling of the extra features
