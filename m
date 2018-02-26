Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2258q2fOKCBnUxukourynn2buSlwFi6PtcUfdCtrkdExBitl0aPnsWMjrTfd/ad4gRFp2ALT
ARC-Seal: i=1; a=rsa-sha256; t=1519676693; cv=none;
        d=google.com; s=arc-20160816;
        b=JQNyiiM4QGb8se7yNkIHu6fXYzPR1DnUO+wpIxg4wr4r84LJSBZ0phZ1aO3HnkgtMb
         jc8InxbWt/v/Hn5Vpbp6Ryfdmq8Zgejtwp4hP4yLzcz+6xLuZp/kH814y+2afPmTiCHK
         RhvtkHtcK5HbciJEaSMWiyeqeoM2s3cYR/LEvTkHizTUM0db7M0Sxam+Z6j34niXrtQf
         UzvYqgayZ5yyyO+wSIHz+w1nPss9bNIY9gc+E3kQm6ZzG58+0aceFW16U8nu/zAEm8dR
         RTr2TJLXo/sN9N6GMddvzcSiKPWevaI53Fgyq+5+JB+1iK/UqvnG+iI7eYfsQQf+GoXw
         sYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pAe6Ssw6U2XkLuXhZo/zivXUbJqzd22af7l3NcEBl5A=;
        b=dsIPFdh/sm1AefiRw4ztiZCuOAohHOuTfLsKIrW8bWOZSX+8sZz1zZET+j5vrWgu/P
         +UfwbRBotB5KndyuvstSkOwBHudC3qfGVIJXTmgEjL7qWs0bd71ISHf9JW9Wp5/ph6PH
         Hl6tETx37O2+TOAcvtVGkeQBh22AFuP7yBH7x+kYKgy7CUS9vwhxez5CQKpG2suqqwkF
         IXWUJOOUKVsIuSJD8UbYuRw1lDISifJRPYtG4/kOmr8BXfZKbezSyxXL3pbWHPAKuaun
         CbkrEa2jwEYbL3iLD48VFGb2JHB6b7UoSdKMahzsivRYMREz1G8qBcZgBd3UmhfQ7TG6
         g9Wg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Gardner <gardner.ben@gmail.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.14 09/54] i2c: designware: must wait for enable
Date: Mon, 26 Feb 2018 21:21:46 +0100
Message-Id: <20180226202144.816692358@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496508464542854?=
X-GMAIL-MSGID: =?utf-8?q?1593496508464542854?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Gardner <gardner.ben@gmail.com>

commit fba4adbbf670577e605f9ad306629db6031cd48b upstream.

One I2C bus on my Atom E3845 board has been broken since 4.9.
It has two devices, both declared by ACPI and with built-in drivers.

There are two back-to-back transactions originating from the kernel, one
targeting each device. The first transaction works, the second one locks
up the I2C controller. The controller never recovers.

These kernel logs show up whenever an I2C transaction is attempted after
this failure.
i2c-designware-pci 0000:00:18.3: timeout in disabling adapter
i2c-designware-pci 0000:00:18.3: timeout waiting for bus ready

Waiting for the I2C controller status to indicate that it is enabled
before programming it fixes the issue.

I have tested this patch on 4.14 and 4.15.

Fixes: commit 2702ea7dbec5 ("i2c: designware: wait for disable/enable only if necessary")
Cc: linux-stable <stable@vger.kernel.org> #4.13+
Signed-off-by: Ben Gardner <gardner.ben@gmail.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-designware-master.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -207,7 +207,7 @@ static void i2c_dw_xfer_init(struct dw_i
 	i2c_dw_disable_int(dev);
 
 	/* Enable the adapter */
-	__i2c_dw_enable(dev, true);
+	__i2c_dw_enable_and_wait(dev, true);
 
 	/* Clear and enable interrupts */
 	dw_readl(dev, DW_IC_CLR_INTR);
