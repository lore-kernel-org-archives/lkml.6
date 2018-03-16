Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtwKpfz9+JdkpQaQeRXzFaMVQl+dYOBKWe61C0yUfJ6iARViG2zx8sXalUWjcYumeGR6sLh
ARC-Seal: i=1; a=rsa-sha256; t=1521214885; cv=none;
        d=google.com; s=arc-20160816;
        b=dwxeuqUi1ogdcYZDYAzDSg0pziUmSnI3dCX1QLaaAlqN/vkfymdywm6VijGzWbfOYQ
         63Mj2JYEAAshweAmq9H1Ez2LNirDwgK/pLzBZKsQHwClEmTKqox1qb9x44cURkWNjq6L
         i7kEOO/s7pf6sZdUMWVDHKHQSnBr3HNsILELGLkmAZddsV7vYgbV7Zy30pSd292EC4Bh
         lj7KZGK1joEJP1KFMwRSGGF9R3llpUjjP5L2kAOAlreZEHq8qJ7X8fB0ZI0hDgNPmK1F
         kz0CNCnH2ChU0UTzVcR7gjRF4qXn43ldVBBIAvMhhf7El89AC2Xi/A4Nald7CjrXqG5d
         rBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gZddgH/t4AnktH2PSexwBGQ6KIvxgKtv0zc4/XBzmCE=;
        b=g85WmzbQfEnZlBhImqKWGFNeuTaD+sCJYDlMAVCw5yEKoJ9mEN6Oy6jOLIXiOcBDHD
         1M3okewOZBSPe7R/fkzc2htO7gALLtT1SURPgAxiVFxnVWKKkHhw3A1YjcceM5fRisqi
         aclfS28uTw88jhwcCfClabGBYDYb5GxPFO6vB12dF/mprEFSeyg2NQISy+IOq1TBnAL3
         ZL9SPEA/fNdX5Kr1R3TLQGyxhkdSDlV6Nf+zfodtqa2IWSeJiFtcnh2DT/3iMyhvTxg3
         5NQHOuubjtDB7DKJ8xrf+MjshbRvMr+ZnpHjyHK5hOrlq8Xzua3SsqTiZRpDjI9mVz+w
         kGzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Keith Packard <keithp@keithp.com>,
	Sean Paul <seanpaul@chromium.org>,
	Dave Airlie <airlied@redhat.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 053/128] drm/vblank: Fix vblank timestamp debugs
Date: Fri, 16 Mar 2018 16:23:14 +0100
Message-Id: <20180316152339.496220104@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109419983324293?=
X-GMAIL-MSGID: =?utf-8?q?1595109419983324293?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Ville Syrj‰l‰" <ville.syrjala@linux.intel.com>


[ Upstream commit bcbec31ce500fe036f75a19bca5c73bfa6dd420b ]

We're currently calling ktime_to_timespec64() on stack garbage
hence the debug output for vblank timestamps also contains garbage.
Let's assing something to the ktime_t first before we go converting
it to a timespec.

While at it micro-optimize the ktime_to_timespec64() calls away
when vblank debugging isn't enabled.

Fixes: 67680d3c0464 ("drm: vblank: use ktime_t instead of timeval")
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Keith Packard <keithp@keithp.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Dave Airlie <airlied@redhat.com>
Signed-off-by: Ville Syrj√§l√§ <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171113150210.11311-1-ville.syrjala@linux.intel.com
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_vblank.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -663,14 +663,16 @@ bool drm_calc_vbltimestamp_from_scanoutp
 	delta_ns = div_s64(1000000LL * (vpos * mode->crtc_htotal + hpos),
 			   mode->crtc_clock);
 
-	/* save this only for debugging purposes */
-	ts_etime = ktime_to_timespec64(etime);
-	ts_vblank_time = ktime_to_timespec64(*vblank_time);
 	/* Subtract time delta from raw timestamp to get final
 	 * vblank_time timestamp for end of vblank.
 	 */
-	etime = ktime_sub_ns(etime, delta_ns);
-	*vblank_time = etime;
+	*vblank_time = ktime_sub_ns(etime, delta_ns);
+
+	if ((drm_debug & DRM_UT_VBL) == 0)
+		return true;
+
+	ts_etime = ktime_to_timespec64(etime);
+	ts_vblank_time = ktime_to_timespec64(*vblank_time);
 
 	DRM_DEBUG_VBL("crtc %u : v p(%d,%d)@ %lld.%06ld -> %lld.%06ld [e %d us, %d rep]\n",
 		      pipe, hpos, vpos,
