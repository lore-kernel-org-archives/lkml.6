Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvifnyIZVuEzNPvEpKliyl8b6mkgcCzVuAwFabWjCOAAMKF0cmMV+YTxVKRO4f5XG5Xmo+4
ARC-Seal: i=1; a=rsa-sha256; t=1521213836; cv=none;
        d=google.com; s=arc-20160816;
        b=bkLsMaWxy4NuHfFcOYMWhn5MDZ78WG+LOPR+qNU1CfKPDqSBiRCd/ITVCjHVixCs/D
         RiiH40PhaW+mhZ/eiBd+SwGaulI3m/R5wNWLxyEOARcdActmB2bUqGQf1HrBLy+OwYPF
         D7Mw6EvjZOZ+TgBNdizvRwStbW0kv7fdNV9tPxwMlzTfAICUOW3JVcrSjkBDs98gY/fX
         4l8V7r8X30eVieC7am3NCJ7ZmSvdR6tercUiMRMk4qeutLtkmVeqzkMdKKTN2nGmnYDR
         rb7mkXkNg+pc7elh5auEUVLKN/d9UVo+0DP44bsX1FjX0WzRr8lf94mJTYU+TM2NFKnz
         XDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rk7at0+25eF0Yq5zx/ja6HMBRb76tWC6gTGC8HugvaA=;
        b=rQF8tJaJPji/lobq55E2M82Eu9BjpZ7cCXnd+k2rj5Qxe8fgakF5/bSSFgw8QD+9IV
         D2An+EWni5x2bf+jAgKQGCUOHvMzFUa2x3kZUDs0sB2VfZRXBU2lv5kSCSATT72dnvbZ
         a6NhAbjMeoRy37GHMiotGmbXyKqeuPdEQ2HjijWvzCeuCW8sX03uiPTq86nExnDWwmge
         juxgmGIxs/GKRZazvkZuhHrKOvNP1SH9xGC7p6w9URS49V/BEkfnFwo+uaJZ6ZPCKC/C
         Z59iB2wdJ1K6mEb/ocZXtqmes0vnp2XXy4JGCXwPMIfkqqSHNqv2tA1D2ufcVH5yq9xT
         yYjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 3.18 22/25] USB: usbmon: remove assignment from IS_ERR argument
Date: Fri, 16 Mar 2018 16:23:09 +0100
Message-Id: <20180316152233.646858453@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108319813454723?=
X-GMAIL-MSGID: =?utf-8?q?1595108319813454723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julia Lawall <Julia.Lawall@lip6.fr>

commit 46c236dc7d1212d7417e6fb0317f91c44c719322 upstream.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e1,e2;
statement S1,S2;
@@

+e1 = e2;
if (IS_ERR(
    e1
-   = e2
   )) S1 else S2
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/mon/mon_text.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/usb/mon/mon_text.c
+++ b/drivers/usb/mon/mon_text.c
@@ -386,7 +386,8 @@ static ssize_t mon_text_read_t(struct fi
 	struct mon_event_text *ep;
 	struct mon_text_ptr ptr;
 
-	if (IS_ERR(ep = mon_text_read_wait(rp, file)))
+	ep = mon_text_read_wait(rp, file);
+	if (IS_ERR(ep))
 		return PTR_ERR(ep);
 	mutex_lock(&rp->printf_lock);
 	ptr.cnt = 0;
@@ -413,7 +414,8 @@ static ssize_t mon_text_read_u(struct fi
 	struct mon_event_text *ep;
 	struct mon_text_ptr ptr;
 
-	if (IS_ERR(ep = mon_text_read_wait(rp, file)))
+	ep = mon_text_read_wait(rp, file);
+	if (IS_ERR(ep))
 		return PTR_ERR(ep);
 	mutex_lock(&rp->printf_lock);
 	ptr.cnt = 0;
