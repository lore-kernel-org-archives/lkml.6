Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/oCVCkLeCOjvMegd2i9Ijm8LU8n9sNyc+VokTTAErFiAgKJbkwniccVfAjj+0fFl9fuiF3
ARC-Seal: i=1; a=rsa-sha256; t=1523981313; cv=none;
        d=google.com; s=arc-20160816;
        b=YTRbzKrg4C8EA0+QmGgPLoYLSM/67+mEB8UBG12P6VG8uiLXYFITL3HTWR4cx2arh2
         dVq1ROPAARMC/LxUIyD1gUDt8U9oH7vM9ao/ZMCopKLTBCq7y0ctvlmnNc+MgQ0bD7Ib
         vEoeaO1dqVq740joW4ij3WQu0Tss0tYIiQFyA5ZYt516bN6ahQwYJrNp860n1AYzYrxa
         Eh97Ie12vwV7ifD9htmJo171y6xl6p+jb/4g1w0Gq4VHUp12Il8dJOth5MIhrXatlFmO
         xW3umc/vmw08EZDXlBTyrcjl1kLuHVKPZOkylbgFgR2QfzfK9aqqRYmrOqYi1ulpgb6e
         eLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EpuajOJ0j/QJtOUu9H8Z94VwvBzZynq/Xm8XAXvnXGk=;
        b=Ol5pP0sfxxDVZ9rv2Qam12ytRiOVcgaSIit0wRlBS7r/HpgJ5hGDqkjIs5eruqjaAD
         wUlvr+IrI3lR0MHUovGZotgDK+ToScQ4IXlilbAupu4lyGHiaK7Hg/15FYWc9l45c0oZ
         /Oy8iPQSr6LZOSik0eN6sOk4hpAti7jiXdZ2AUrCcp81HbF91itoOXFZTKMWDBslbLyK
         NXw2xmCzTtCNgkLZAKwnwremRi0pGfWlYPDFuWruB1xo8Lw3GX9hHkgn5S5qHOC2bvG3
         hGQJVJZqGIn7V73RO+BJKIgRRMIiKF3NePqChkLOSN7D4CEU5e7JoURumjokYgJjcn58
         Z5hg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 4.9 02/66] parisc: Fix out of array access in match_pci_device()
Date: Tue, 17 Apr 2018 17:58:35 +0200
Message-Id: <20180417155645.967397478@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009707455572846?=
X-GMAIL-MSGID: =?utf-8?q?1598010229982088727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -648,6 +648,10 @@ static int match_pci_device(struct devic
 					(modpath->mod == PCI_FUNC(devfn)));
 	}
 
+	/* index might be out of bounds for bc[] */
+	if (index >= 6)
+		return 0;
+
 	id = PCI_SLOT(pdev->devfn) | (PCI_FUNC(pdev->devfn) << 5);
 	return (modpath->bc[index] == id);
 }
