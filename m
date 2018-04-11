Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Z5Nz+WlLg8p1N/WCHMdVGITkEH94IpK1oJ/E4Q1ijJTDs47/FLsWqZqWFwUzm5AlZFSKW
ARC-Seal: i=1; a=rsa-sha256; t=1523473220; cv=none;
        d=google.com; s=arc-20160816;
        b=LxgXsMHsxePg8P1gURXOBqytb3j/KWzCaBvrKPa2ca+C/LmaXuMjMWpwpK9/D5GCHe
         fExKjdrOq12oTe4DWEmWKNwwLMJ0KFOW3j+7wAo8faGYmUmmKiUpuMIuHhfV06h1cA3+
         lIbybZHHsaUSmfe/+DJ+7Da7/td2hw4eabWnYrH+NA7JscpHgLPiSPzt96rMo4FaBkzc
         jxsjHwlQnyl0LRExZnEiI1dbtLpaGmk8Tj3uwy4PN2ikjBUTZzlB/JSKT/C5EOFk4A6w
         Hnl1Zz3Suj3Q/6dyKVJrTwXs6NRt6lIHmuv8qLOs0r6IWWL94OX8gQCrfVOwezzzKVmw
         IBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=X2tY1FGnqb3UoTg9TF5cIfBMlZ3EQswMCxMEZnGNduE=;
        b=yoj1i0HSJxiW9bxwixz0rjAZ3rdk503u4C3j+eDu+EQ9qkyv12KTedMY5jUAoP/ycw
         uCpGuU1Faiqr+YB9tkJKOHyIX+YXU69X5umDWu5wmARvvG3p+owCG9LPhCn43PHO7rlj
         Jsy1Fq0vaDk/y3G3HySPOERawn67LG2cTRKh0TnGxvjhVHh+5IYyGHf2pJ1mgYreXlo9
         4FVKdDa7WBhbA2XClhnIFzZQOPlNlQVD/r996dj9AO7NDaW3MUNR7GLHKNDahVg5i8Dt
         vOQwdhCbjh7kSnDQyuDFSmC+wSaj10nRGAWjhIuBTu/9ctp5fYiCTB4MHB7fUqccEg6N
         4q5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chen-Yu Tsai <wens@csie.org>,
	Rob Herring <robh@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 168/310] dt-bindings: display: sun4i: Add allwinner,tcon-channel property
Date: Wed, 11 Apr 2018 20:35:07 +0200
Message-Id: <20180411183629.780754443@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477455792879466?=
X-GMAIL-MSGID: =?utf-8?q?1597477455792879466?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Ripard <maxime.ripard@free-electrons.com>


[ Upstream commit 22662f12768f971809b478386d9cc4947d00497a ]

The Allwinner Timings Controller has two, mutually exclusive, channels.
When the binding has been introduced, it was assumed that there would be
only a single user per channel in the system.

While this is likely for the channel 0 which only connects to LCD displays,
it turns out that the channel 1 can be connected to multiple controllers in
the SoC (HDMI and TV encoders for example). And while the simultaneous use
of HDMI and TV outputs cannot be achieved, switching from one to the other
at runtime definitely sounds plausible.

Add an extra property, allwinner,tcon-channel, to specify for a given
endpoint which TCON channel it is connected to, while falling back to the
previous mechanism if that property is missing.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt |   11 ++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -47,10 +47,13 @@ Required properties:
   Documentation/devicetree/bindings/media/video-interfaces.txt. The
   first port should be the input endpoint, the second one the output
 
-  The output should have two endpoints. The first is the block
-  connected to the TCON channel 0 (usually a panel or a bridge), the
-  second the block connected to the TCON channel 1 (usually the TV
-  encoder)
+  The output may have multiple endpoints. The TCON has two channels,
+  usually with the first channel being used for the panels interfaces
+  (RGB, LVDS, etc.), and the second being used for the outputs that
+  require another controller (TV Encoder, HDMI, etc.). The endpoints
+  will take an extra property, allwinner,tcon-channel, to specify the
+  channel the endpoint is associated to. If that property is not
+  present, the endpoint number will be used as the channel number.
 
 On SoCs other than the A33, there is one more clock required:
    - 'tcon-ch1': The clock driving the TCON channel 1
