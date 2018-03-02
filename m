Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvIUWObRtUFDUWpX6IUmniWY0JiWczQyigqvXUkbJz3gumZ1mUJRvuP34C82e5/nz/Za9zx
ARC-Seal: i=1; a=rsa-sha256; t=1519980966; cv=none;
        d=google.com; s=arc-20160816;
        b=HhOYAExT5qCaKAW3oDJt85DYi7CAWe1TYak1FcLjp7q5dbCMxLyxi4yr6fz6KElZV9
         FOlQs8PqEDbZlAFoxmJYrA2/XJb0yiwYu9f+zszFSEGChIYgWw6Jc7M9VQ7PUV5D9gjc
         rNZn1g84biG1zHKoEXWPBdbOkhyEvdHfyIYlBXfn3S9wFUECD0WVIH1PUcCegcTnLbxC
         /q7fRAA/GipBNoBsNZ3Y6hU9ua22PL8mPXYiYauCyf3NAXq+Z+dQlqV6dfuACN8yaw8P
         WAf5YIeu94gE/mPDI5Z6kD3LbjhKgdUsCYoMS0RbcmIEzmOY5lXQtwhokKRYyftc5Lop
         XngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FuMbSUTuauZ7D3T5sDtlvH5Y5Vvf90VpJsO4TVB0Yvo=;
        b=fAkHAUDjg7wfmrsz6gaN98oEWl4UwpeQ2CrM8bwJQCQAsqJ3ztgXNgdaJxzIgaJyYo
         cXH/1HAzelSkd8iF1N3s+lH4tK5iLaqU61jCExJO8a4AsYt2iXSFoOyOmErPY5jZNd1D
         adq7lGhFGyC+GTlWkpjLkwOilWVDvesWa16CLE+cnGmAD4N4pCBH003hlvwfjPbkP6aw
         0pbDn+hujxXyrxSvFqkXBWAOqHF/kWHM967MFS6nBGV4JIBPEtR+Pj+DMikZ6tirmbPz
         fnpbdPHG+kt6Ikg/sIEvtHxQ6vW/HJ94tLuVZ+cxbIa+tqmrJVuHWesWdN0NIDhwssU0
         ZcYA==
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
Subject: [PATCH 4.9 02/56] i2c: designware: must wait for enable
Date: Fri,  2 Mar 2018 09:50:48 +0100
Message-Id: <20180302084449.770255417@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815562317859663?=
X-GMAIL-MSGID: =?utf-8?q?1593815562317859663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Gardner <gardner.ben@gmail.com>
[Jarkko: Backported to v4.9..v4.12 before i2c-designware-core.c was renamed to i2c-designware-master.c]
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-designware-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -507,7 +507,7 @@ static void i2c_dw_xfer_init(struct dw_i
 	i2c_dw_disable_int(dev);
 
 	/* Enable the adapter */
-	__i2c_dw_enable(dev, true);
+	__i2c_dw_enable_and_wait(dev, true);
 
 	/* Clear and enable interrupts */
 	dw_readl(dev, DW_IC_CLR_INTR);
