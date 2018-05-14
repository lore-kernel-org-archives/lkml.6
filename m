Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoB/qmb4MBG3kGxOJvnF/5+1UJXwqNh3578dfc38eXBlBc4bfitH4fyobhyhZMm1Pjg4Rqj
ARC-Seal: i=1; a=rsa-sha256; t=1526281167; cv=none;
        d=google.com; s=arc-20160816;
        b=kfwqNvl9zQ3QZoChh+GWbeCGjGyOad3K2PdySrnK8LqnjAojQIvHhwIffTX+3u+v03
         x6B2cwMxEwzDWSldmre+HeGGeJv7+gm9enkA9pTAm4LSg9q/H67zOh4E69hkL2JiZG9R
         yH+ehJ1HBXc67p6OdMo1fed3uJhCQ3UyarV5nxeEvAKLjXlwVvO0cmJsscA/31CO/XGM
         wHVm2q8fWJ8H9G0QlMEZ2UrIhZjC4LckrRR7CzuAbo/bEvmEgCzIGiYKtYdl7Y8NQdm2
         o9iOMK0jqDF//yYfSF6VI7jaCBGzPuhQUqY0/2qdk3f0D6ZLI8HaUplQnklAZpPrWv9O
         FjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=qjfERe2xeMLg1BoZWkdCXM4uwpAYU0b1rr1IR/4WQcA=;
        b=NHROOu6tQMv6spiOaT3ee8ORqMFr6/D9aBaexM2r1LLSJJzUHF+3bzHVPdvjcmwu5P
         P9xDGQ0YNDelWsM2LVhq5WyGK+i7CGeSPwvsMNb0509gVxyFAkbmrRGL79WwDdxdke50
         Wnl08HAfDI8lWzawZxclBvICPv7QQ7p2ox6rMjh0ktDw+w2Cptkl+t6psFmdN7Z1+3Xu
         yAHxBadjXO4Z8TqDMxotsoNhdcmJBu1ypxKuWLiiK0spDYVpvn6YI3vk1q5KV3kriiha
         XpgmdiEP+/GK4L9ocJIb83qpNe+Tp1ofYYuTnQ4JuFXo75eVR9e9XZXTp0vt8e/4dC7i
         yCDA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GXXjdM5A;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GXXjdM5A;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Boris Brezillon <boris.brezillon@bootlin.com>,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH 4.16 42/72] drm/vc4: Fix scaling of uni-planar formats
Date: Mon, 14 May 2018 08:48:59 +0200
Message-Id: <20180514064824.982426061@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421470287342593?=
X-GMAIL-MSGID: =?utf-8?q?1600421801684438869?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 9a0e9802217291e54c4dd1fc5462f189a4be14ec upstream.

When using uni-planar formats (like RGB), the scaling parameters are
stored in plane 0, not plane 1.

Fixes: fc04023fafec ("drm/vc4: Add support for YUV planes.")
Cc: stable@vger.kernel.org
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20180507121303.5610-1-boris.brezillon@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vc4/vc4_plane.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -557,7 +557,7 @@ static int vc4_plane_mode_set(struct drm
 	 * the scl fields here.
 	 */
 	if (num_planes == 1) {
-		scl0 = vc4_get_scl_field(state, 1);
+		scl0 = vc4_get_scl_field(state, 0);
 		scl1 = scl0;
 	} else {
 		scl0 = vc4_get_scl_field(state, 1);
