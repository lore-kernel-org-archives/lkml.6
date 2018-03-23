Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsvbSbFFII0GtVctA6l95jU8st7jOUXai+fe7SOBqjHjaGmfM5ZCafibwZvLmrbeMcDyD6P
ARC-Seal: i=1; a=rsa-sha256; t=1521800106; cv=none;
        d=google.com; s=arc-20160816;
        b=yhfom+oZiT+Bp0vQTvyQs/5llP5AentI50rcOlbtbJUeLE2O51xRIpqdw55cjJEXGv
         m1W1B3krKCo8LBfqT2yMqtrkC1TE5mCNXWLG/f8QnFDXGf+vcAEEDLGOx66pu2LY1VDt
         Lj+Sv5JSb3N62cbdlNGlgk7WyJxqi4xOjyrBLyfqW8RWJxo9OhLgJgxdaROvAsItC0Gf
         CP/PhGYGdPR4d9vXDeKunuoEmdfa7RI2caH9o09DKx42VDB7Z09X/hm00P813JVK8oM+
         XHv0SZmsfQaeCcCdigVpNQnaKrIeNX9BZ8GHjPTAnkM3EP6yjckZhOBjO8f1ul7J456n
         CkXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3RLUEauIHDpAGPQKi45p2MDjg8XPPgQuJ/PkXbzLxyA=;
        b=EvFQfVxm3fa4sb/Og7lcvEYScRSNLPbNbtKHLJVybf+SiVLSqL2BDjGDL2Is9eCLiY
         l4oisb09txpS16qwGlKwZGEHaIpwBaahK7uyZQ4QpQxUI0zDrFY72H21yKkmaHe/ewk4
         vQ4VNEs12KHEbIASo9CII8lO9qFLgmosE84zUtjOGCxX7M2yskAQ36wT6FV/5Q4MNuji
         MNJ0pldVGxyvQbip5meFOckRn5BUVmHLgwJtSVium9Ki+zbM+lK9291DmeZKRNBKX6ub
         X3jsWgD3RDN8WWF39zXawYDddRY3trQMAaCT40ZfM9dSICO5QjJeHicHMOFTBkSRTzFs
         qSTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 36/97] ASoC: Intel: Skylake: Uninitialized variable in probe_codec()
Date: Fri, 23 Mar 2018 10:54:23 +0100
Message-Id: <20180323094159.693320370@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722513889701138?=
X-GMAIL-MSGID: =?utf-8?q?1595723068883826844?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit e6a33532affd14c12688c0e9b2e773e8b2550f3b ]

My static checker complains that if snd_hdac_bus_get_response() returns
-EIO then "res" is uninitialized.  Fix this by initializing it to -1 so
that the error is handled correctly.

Fixes: d8c2dab8381d ("ASoC: Intel: Add Skylake HDA audio driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/skylake/skl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -280,7 +280,7 @@ static int probe_codec(struct hdac_ext_b
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	unsigned int cmd = (addr << 28) | (AC_NODE_ROOT << 20) |
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
-	unsigned int res;
+	unsigned int res = -1;
 
 	mutex_lock(&bus->cmd_mutex);
 	snd_hdac_bus_send_cmd(bus, cmd);
