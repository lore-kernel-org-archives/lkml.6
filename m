Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsN1PQI7kPu9zRw8GcSocjkH0FpKOpl2GzkAyPB8lLTOPo7e9FXPE3rH/Asl8X8CKH5N+jB
ARC-Seal: i=1; a=rsa-sha256; t=1521483723; cv=none;
        d=google.com; s=arc-20160816;
        b=0PKnk5pZo1A4NoL3jBd3LGluDVBnLGcXDG7GHOL7pwJh5zRYStp9aRE6WukCOhZ7hE
         AUfB6tp+3k51QLOtQLnrLqW2AIHGpRxDkW8VcTy11BTexIOhNfS2VpocbrbaGAKRJqEE
         6R45un8H4L2rMjYwYNj2C2qWv33jWfnv43Bg6YVzSpGRZTVzvODWOm/Z04Az+oufxN0Q
         hoiH2V8SZbyhnhDz/bQDXWjYJ2oKUZLzL6vBhGYJrn20LLx4u+kZaIVgF9nw8ePOa1sJ
         TuPpvGkG9LJufjTzjcFD1hWSaTeyEfsPZr5GQtC11IjFf0/g6a0ZCsT6kkf1TBASXDXd
         pB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4mhWavUPIIIe+aTXDJtnHuZzKYbqZ3bDbTru3DpdkJA=;
        b=ZzHPq7Nu/ELF/45raA8GPF284dTyGQMGi2QViI0bhnb9vwGQpvixE8Ou81F85xMQjr
         Y0sF8JjpbNXZhn0XwLkDENzOPxdi1wXFV+wKgPsDnHEcc5RCrbSzJKILPvre1gynCqyc
         3wG24lC2uMbbVsO+vgKLhTC1vmtONs0cw3dfhK/FffVCZjiHAeeyGNoBRcBYqPcNehEY
         GZApDH3zNO/78+uPKkxKqMH+QzMi0U2j4pAM2/P5QPiThtlyodIYF5l+gNc0CVR8t1ok
         v0JuKDxodeob/Lw52rY4Fw7kkOPgtXwH+NafLt9Oi23xGCzBA7XvmmNYgsXP8Z3cjFhP
         o6pw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrey Rusalin <arusalin@dev.rtsoft.ru>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 092/241] NFC: pn533: change order of free_irq and dev unregistration
Date: Mon, 19 Mar 2018 19:05:57 +0100
Message-Id: <20180319180755.008323601@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391316629243077?=
X-GMAIL-MSGID: =?utf-8?q?1595391316629243077?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Rusalin <arusalin@dev.rtsoft.ru>


[ Upstream commit 068a496c4525c638ffab56449d905b88ef97fe32 ]

Change order of free_irq and dev unregistration.
It fixes situation when device already unregistered and
an interrupt happens and nobody can handle it.

Signed-off-by: Andrey Rusalin <arusalin@dev.rtsoft.ru>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nfc/pn533/i2c.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/nfc/pn533/i2c.c
+++ b/drivers/nfc/pn533/i2c.c
@@ -242,10 +242,10 @@ static int pn533_i2c_remove(struct i2c_c
 
 	dev_dbg(&client->dev, "%s\n", __func__);
 
-	pn533_unregister_device(phy->priv);
-
 	free_irq(client->irq, phy);
 
+	pn533_unregister_device(phy->priv);
+
 	return 0;
 }
 
