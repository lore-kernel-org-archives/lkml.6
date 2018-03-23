Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvXdfVJeqH9PI7sCGXnR3wW8kVMdsI8gZnrypmLvsOqiaSQdsmLoXS6fXPh5KVvKEnpOqgD
ARC-Seal: i=1; a=rsa-sha256; t=1521799036; cv=none;
        d=google.com; s=arc-20160816;
        b=Gzo2NJ8acolt9H2ZG8Vtk3SEjuLQus+hN9e+wPnuWL1Sz8ccDm0lVKo4dvofIFZ+F3
         4arhsXi2J7zYFRHsgx8Xqn+llp83ryj4O0REGXuwK0fl2tZLrzWuHHSi0ew3w9BE/ZzQ
         YrEC9N6i2wxDO35CzilHfTjwM2VFAUnzkGJtUAg25dpeNzVRUddrgzUI20wLUhIb70fn
         33H2/AzVoc7uOSSZQT9dAki/HKGabalbSDNGjn9KCFJI0e6wwnpQFIxSAegArVqtC5VI
         /NtoUIDbHk58H+Htwh5QvYw+E2Pz6OiB8PLGIsfLChtqPNlYfJeNVnG4nbgsdpgUGqwj
         g8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xzIKSj962FDq80FN6HneAGIjw9STRpEo6qDjzAjw6F8=;
        b=u0Kb4SCkmNP0ASWMLoDldkR/3PrD5mEyHOntR4M54DwLDXcJxMslm+jdoryewQYlds
         wLhOnqxl7e2qA5Kfw2mTH9HXqJJPvQ8ApeqoPDtziqHBktTVZgKJ7XrE4yhbIyXMMij8
         oHUPcIbvN0wEtMz3Nt4Azw9JA/x6LxubvJMxR6eExiAdnXh+vztwEohkwzi24KBDd4JI
         NYna40xHGwTOHroQ8bjl5w83cSF+dddIWwyMZmtzYG5hjuzRjfsh93vb9X/aq2QGbaAD
         Mt2jannkT1QhbAQzFRkXm00DBxd8rvcHaB5ZMsxTkF352wPN95F054Xh66BK79sX/t0f
         RJqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 22/84] qmi_wwan: set FLAG_SEND_ZLP to avoid network initiated disconnect
Date: Fri, 23 Mar 2018 10:53:36 +0100
Message-Id: <20180323095415.253246377@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721946694563316?=
X-GMAIL-MSGID: =?utf-8?q?1595721946694563316?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Bjørn Mork" <bjorn@mork.no>


[ Upstream commit 245d21190aec547c0de64f70c0e6de871c185a24 ]

It has been reported that the dummy byte we add to avoid
ZLPs can be forwarded by the modem to the PGW/GGSN, and that
some operators will drop the connection if this happens.

In theory, QMI devices are based on CDC ECM and should as such
both support ZLPs and silently ignore the dummy byte.  The latter
assumption failed.  Let's test out the first.

Signed-off-by: BjÃ¸rn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -826,7 +826,7 @@ err:
 
 static const struct driver_info	qmi_wwan_info = {
 	.description	= "WWAN/QMI device",
-	.flags		= FLAG_WWAN,
+	.flags		= FLAG_WWAN | FLAG_SEND_ZLP,
 	.bind		= qmi_wwan_bind,
 	.unbind		= qmi_wwan_unbind,
 	.manage_power	= qmi_wwan_manage_power,
@@ -835,7 +835,7 @@ static const struct driver_info	qmi_wwan
 
 static const struct driver_info	qmi_wwan_info_quirk_dtr = {
 	.description	= "WWAN/QMI device",
-	.flags		= FLAG_WWAN,
+	.flags		= FLAG_WWAN | FLAG_SEND_ZLP,
 	.bind		= qmi_wwan_bind,
 	.unbind		= qmi_wwan_unbind,
 	.manage_power	= qmi_wwan_manage_power,
