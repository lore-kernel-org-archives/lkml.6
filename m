Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225h4OeXixRtW4Erd0XvrXaoUI7B3PUIt0IvdJObkSVYC/pdgk5ykYERoNCwYB6JkdAuVHbk
ARC-Seal: i=1; a=rsa-sha256; t=1519410942; cv=none;
        d=google.com; s=arc-20160816;
        b=x+yTsWZ1S8G0bABXgWUKjemCAj/W32jhu7z5a3STl94sXaQc2nJGaL73KsBHNVFHUc
         /ymknGDseELQnNl654JrX/hP5glItntgkFJm3dETbJzALI9/4oKMeD1ekjZ9O7koK9dU
         RchwUd5Kb5pl1vGLi1AhYgn2RQ4Vu7qd4WvR2gm7kX3aZuG2lcCqSNpt3qY3PYnSeZEi
         lKl/PlfnBzcA+v0jiaFrOdoBnc/XZvZ/PSj687a6T7qWlKYaQHHvxHY/MPdh8czO7gaY
         TzJ9nrp1JSYUSLgjIzC0BGJQjVvyotr6ycUODiKwMuh2Y0RuYLyfBfu8pmYK0Wi/Qr8i
         kv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xO4ylNpYN9CNBtcbjuNhgF82U8K5wydphxaW2HANwMo=;
        b=k0R1RKpX4w2YwMTFLBUjWqJ6lDy26C6rkh8otTRp1WmZDtbpgpr2l+9V3Fn69rGxMV
         CWPLqb2zEbZj6Ygv1+gmXoqiDMLDuryknLiCvuZTcDVowKj0q0Q0yXK3MdvXzAEy+DCD
         1UrodVxkt9k5t7lqKhFjnth19V9SuZSfw68NIPIyCi0J5nMW2PBCkibhkBnytyAMB11Q
         hP67S6tZX5swpWIXvG4lc9GVm8D5hFKTJ9VoweSyqtyxBMalsmjl2H7KokuZJBF4Mbyr
         ZhBwxUfeLNoi26lXu34t2IE0OahUw1BuW4kHShcAXkXWoK6Bs7YTPJeFg1aZXCusb8uq
         Pi9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 064/193] vmxnet3: prevent building with 64K pages
Date: Fri, 23 Feb 2018 19:24:57 +0100
Message-Id: <20180223170335.983494978@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217848180784820?=
X-GMAIL-MSGID: =?utf-8?q?1593217848180784820?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit fbdf0e28d061708cf18ba0f8e0db5360dc9a15b9 upstream.

I got a warning about broken code on ARM64 with 64K pages:

drivers/net/vmxnet3/vmxnet3_drv.c: In function 'vmxnet3_rq_init':
drivers/net/vmxnet3/vmxnet3_drv.c:1679:29: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
    rq->buf_info[0][i].len = PAGE_SIZE;

'len' here is a 16-bit integer, so this clearly won't work. I don't think
this driver is used much on anything other than x86, so there is no need
to fix this properly and we can work around it with a Kconfig dependency
to forbid known-broken configurations. qemu in theory supports it on
other architectures too, but presumably only for compatibility with x86
guests that also run on vmware.

CONFIG_PAGE_SIZE_64KB is used on hexagon, mips, sh and tile, the other
symbols are architecture-specific names for the same thing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -411,6 +411,9 @@ config XEN_NETDEV_BACKEND
 config VMXNET3
 	tristate "VMware VMXNET3 ethernet driver"
 	depends on PCI && INET
+	depends on !(PAGE_SIZE_64KB || ARM64_64K_PAGES || \
+		     IA64_PAGE_SIZE_64KB || MICROBLAZE_64K_PAGES || \
+		     PARISC_PAGE_SIZE_64KB || PPC_64K_PAGES)
 	help
 	  This driver supports VMware's vmxnet3 virtual ethernet NIC.
 	  To compile this driver as a module, choose M here: the
