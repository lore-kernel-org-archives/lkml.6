Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48UKwjuiyMZH7IHbpUY4LFr2G9XvGcd3odzuUWhVLRcPw5MwdsYsjKrP5PUJ2JYpSqKPFa3
ARC-Seal: i=1; a=rsa-sha256; t=1524406826; cv=none;
        d=google.com; s=arc-20160816;
        b=My7yBiGswe7ij2GDaPX8kfUtmsEBbuEe1Iu0DywwcUAF/m+Hs4qRWa3OqNi+6hYrdg
         sbhw3sPlVyi7ORfMwKTZ3Kf8d1RTmZs9GsXWQ1luJeFzdgKd4++YhPQByOYAglqYiZIR
         7iaZDbfPb8cH2K3XdSbaWWGM31CZml3/Sn01YF67d0tKVZS0wf2XS1jLqlPj+QGn2whH
         0HHfnQErIFwikhT/SlKz34XFwTyuUT0QPWT9GicTppAq3oqtRYK49Ben+FZEDjZ8NVF8
         cpFW9dC7SuhZt5+LKxhg6/o+ArOZJtrE7TTZYQk9F4F4Un9AGq+KR6ePT8qefLWOVr+6
         Gsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BxINKcR3zGoqj9mJZapRY+lHoHLANBnwJXwJyRycszw=;
        b=tRTUL0ejsCgzYhfhX2ETk0WEQfiyuf27dNDFarA1I579pICmGcEPj/WDoVNHn9dnmc
         usI9XnGNZ2OcsNonxZhcckqVZNbsFRx3EBnvl+qUD1LWm3XUgOcGrRjrDCsR2/FC+7cx
         fETIQSFvLnQnDx+1x/tdleJATtDBRH5faUbxEvBh1LDPi3BK0Rd+xxWWpM49o6R+3SMG
         6wS+02kAItM1bSn7t+h0dq+Ixn7FzOChONXJ8sapoAuzX9B8H1aGmrMk557iXUgLsNeD
         NcnikC8rAXWsNpR7FMD51B91/mLRwRm3cfrmKETxZ2ZA9/VaU1JibLy417h1GlBYUEv8
         TlPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 3.18 02/52] parisc: Fix out of array access in match_pci_device()
Date: Sun, 22 Apr 2018 15:53:35 +0200
Message-Id: <20180422135315.350623373@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456131034526081?=
X-GMAIL-MSGID: =?utf-8?q?1598456412943850394?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
