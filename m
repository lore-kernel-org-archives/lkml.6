Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+m5buzPLqQAEONJV/KFYCmSJPQo75yQMPrK395puyLlBfxENRGIf1RGJtK6p5DCuI4KnVp
ARC-Seal: i=1; a=rsa-sha256; t=1523981008; cv=none;
        d=google.com; s=arc-20160816;
        b=TtDD9ICIP4q13Zxv4inBaE9S1TlWYCyJxT3gIHyA3u4T48toYliujF07LqvRdzCLFI
         4ovu1EXkFYb1OEN14M9BFg0fnxpmWs3gCVhpkZ9LP1XoS9OiHqMK19ksYp16cMoUf6qS
         O2L06VAinSsmqplwIVyP2YxpXMbKcqYulXFYopBKv6fT+vQfeCTgsDdv2HL6MP2TgEm7
         AxBdkDIwFKwvfAdiatwE5C+I6ztVsixbyliKA+sSea9PrjdkWvC7FQb/qatkndVpwBzB
         /gNl76p5sDucCm7+URIea7m7glJhndp0x11ZF1no9J2H3jFNN32OkjOy0pdUMtAt0QI0
         T0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rNO8Z3XwFBOzOnYu0zJEcyA7M7kQrCmk7GMJ2Lv96vc=;
        b=fSo+SHGzTXRksMn4pLb2gxg1g8x+DKOuD3emkQKXB0GOeOKlxpTKCBWdFcJf/hdDpZ
         Oqicsm2qaNH+S5otGV+BY8QZdy90qiq9fiOyXzH5A/VNbph+ENFkcmUEFH4zjXRc9ul2
         o1FYWdWO5HoKZTwLhZiLtSOcJF8tTnQUojdsyardu6QKl+3YcjpeZTvEWNe5v7ItGWjB
         dg0dpKWA9AXxA8v+RAPJJ3AjGgcbd0cxhTbPf0wyN7yIaOYzp75rtJQH9dbEPFSDYwrD
         w5Qcu4MYRAHHAgvquq6qwz+0NeyR/wxlKGGrbeAF//e761Zv5ebe5TQDgmSXY54xHD5C
         5mWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 4.15 15/53] parisc: Fix out of array access in match_pci_device()
Date: Tue, 17 Apr 2018 17:58:40 +0200
Message-Id: <20180417155723.871292683@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009707455572846?=
X-GMAIL-MSGID: =?utf-8?q?1598009910905770124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 615b2665fd20c327b631ff1e79426775de748094 upstream.

As found by the ubsan checker, the value of the 'index' variable can be
out of range for the bc[] array:

UBSAN: Undefined behaviour in arch/parisc/kernel/drivers.c:655:21
index 6 is out of range for type 'char [6]'
Backtrace:
 [<104fa850>] __ubsan_handle_out_of_bounds+0x68/0x80
 [<1019d83c>] check_parent+0xc0/0x170
 [<1019d91c>] descend_children+0x30/0x6c
 [<1059e164>] device_for_each_child+0x60/0x98
 [<1019cd54>] parse_tree_node+0x40/0x54
 [<1019d86c>] check_parent+0xf0/0x170
 [<1019d91c>] descend_children+0x30/0x6c
 [<1059e164>] device_for_each_child+0x60/0x98
 [<1019d938>] descend_children+0x4c/0x6c
 [<1059e164>] device_for_each_child+0x60/0x98
 [<1019cd54>] parse_tree_node+0x40/0x54
 [<1019cffc>] hwpath_to_device+0xa4/0xc4

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/kernel/drivers.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -651,6 +651,10 @@ static int match_pci_device(struct devic
 					(modpath->mod == PCI_FUNC(devfn)));
 	}
 
+	/* index might be out of bounds for bc[] */
+	if (index >= 6)
+		return 0;
+
 	id = PCI_SLOT(pdev->devfn) | (PCI_FUNC(pdev->devfn) << 5);
 	return (modpath->bc[index] == id);
 }
