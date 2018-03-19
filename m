Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvB1iZ9DiCKpCqJB246QIAHoEzwKfGSCexleRmR1Dn8q+yqOT+W2I2DElfab6tTVisyl1Q4
ARC-Seal: i=1; a=rsa-sha256; t=1521483607; cv=none;
        d=google.com; s=arc-20160816;
        b=nsEel2L/UaRAhJA+n2wnwst10hTwuTHrFuuCuRWmEslE0ifrJJKPtxy/sEKKHxtzoJ
         XMaePRYYkHq8YMnmOTO266EHifUX9z9li2XRaFfjA0Z8poQVAOZR+dKVSFjlfM8FzSvJ
         C/GbXLM2caB19MOzBNb3pBXugo0AuRp3rAHloUu0/CLtdvCaMagt8YESqr6lCETaL3H6
         uQf+YoI883KpH81zESEHRsyJj16MWYrNqzVNX/qLLgCVxNgFVGiGAzgar8WUiY5SToIl
         9CujIUEv4tDfF++/rwAK+L61l+EDKxuDosJI5gYLGisJYs3oNfrHacQrHDnZR+JW3tK2
         qmDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Gcpt9v0NUAcomxSGzaUfPdCftsUyFjfB1AqKclmUM8s=;
        b=cHIRCPZjPXugrJYkw5MGxMd2sThFbnQRlzHU9mk4ZEkaUB1puOL4fayZHVWi8kwcGq
         3ajDXnz8wZ+fTEkRCIINbWfAcbQMlgAUw0GYmGv3uiE2DCfFoMoeFQ6IoszMwFNEg9pv
         /g9CbrdCyeCICJwhy6F+Xjsz5aZmEk5vX0W/+EfXX924lcQzgK5ghWxBHpu4dl+J+17Z
         90KRovLao5VAerbKwcCvxwyzKZGeZ4yaWAidOJCb7d0Kny76efq+6lGfHP0MvPgrI8U8
         vcIVirzIMTd5mdA6rD/iOczh5KZeUEQmQQ+Pt3M/BL4dx6tyxhJ3+s7/fVGmJmVOWOmO
         zRdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 050/241] of: fix of_device_get_modalias returned length when truncating buffers
Date: Mon, 19 Mar 2018 19:05:15 +0100
Message-Id: <20180319180753.285714415@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390508983075525?=
X-GMAIL-MSGID: =?utf-8?q?1595391195355477637?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>


[ Upstream commit bcf54d5385abaea9c8026aae6f4eeb348671a52d ]

If the length of the modalias is greater than the buffer size, then the
modalias is truncated. However the untruncated length is returned which
will cause an error. Fix this to return the truncated length. If an error
in the case was desired, then then we should just return -ENOMEM.

The reality is no device will ever have 4KB of compatible strings to hit
this case.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -223,7 +223,7 @@ ssize_t of_device_get_modalias(struct de
 			str[i] = '_';
 	}
 
-	return tsize;
+	return repend;
 }
 EXPORT_SYMBOL_GPL(of_device_get_modalias);
 
