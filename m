Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs6D+o2DTzp8R4wRDiCGTsIZ/Y2leLhL2HF93aI7O3REhilnhSYdz58aECp4ec7k7XwPZHo
ARC-Seal: i=1; a=rsa-sha256; t=1519981418; cv=none;
        d=google.com; s=arc-20160816;
        b=lYhbtQp3dlj/Trvh2ohny5nxxOOJwHxxuWUxt3BHvS9Itecrau8i8YITnCgrvx5ije
         O8wgdK4VO444UhAzH85Xuy2S3Kyu2Dpb6DW2UMCLm4lmmx/uP3ohESARy4tM8W6yGGoV
         eoo7y7AkMbbYbOExEB7iwUgbmR1Kg1J0aHiQ4Pw9QjxNS9g8b7OF6RuNbAuEc67UJXV3
         cL3LcyVY8AIkY3za/swY/ReHMa58kFV0XNBl2E1OvWyp3Smw3IfT4rXGEkwlb1jxvTF5
         VrAPG8aTMybQ/9HEZ3dn3DeliwDvHu9jIIk7X2bR6pXPBSOHAVpiRo+JHEq2MRHoBBTi
         yYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EBksJ0PLKMELuC2WD+/XamtVEFikEcsu9nVaWDDui0k=;
        b=nznHMTNpIE1wXSABTjuOyTHSnulJA65GEMyv3QjL/vkBjNNXFikNdVOTZulWBO6hNB
         M2Q2HA61lzx81WuL6CY2BAHn9slp/RAPyMu1lmwS77hkC8kYuG2JnWfgbQQVBocGIGAH
         KctYe70VPVkmEEgb08KUzWgXhEoPPyY07yCQxc0kyRa0scMSrZyv5+Z4DXmQ6z7lKQ0d
         0X97GLUSf/9W1p9oaqbEiF9Q86TyOibHal91IwAB9QWs6yq8kxuCq6WkB25Ozc+LcXJj
         gCzD2L7mZlnejCf6En5fXfS8jGgT+wh0zdmyBaBp9+/Jr8u61VpB4TTtDvtojLNgPVCj
         OpgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gui Iribarren <gui@altermundi.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 085/115] mac80211: mesh: drop frames appearing to be from us
Date: Fri,  2 Mar 2018 09:51:28 +0100
Message-Id: <20180302084507.286094765@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815488517777633?=
X-GMAIL-MSGID: =?utf-8?q?1593816036039648305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>


[ Upstream commit 736a80bbfda709fb3631f5f62056f250a38e5804 ]

If there are multiple mesh stations with the same MAC address,
they will both get confused and start throwing warnings.

Obviously in this case nothing can actually work anyway, so just
drop frames that look like they're from ourselves early on.

Reported-by: Gui Iribarren <gui@altermundi.net>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/rx.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3632,6 +3632,8 @@ static bool ieee80211_accept_frame(struc
 		}
 		return true;
 	case NL80211_IFTYPE_MESH_POINT:
+		if (ether_addr_equal(sdata->vif.addr, hdr->addr2))
+			return false;
 		if (multicast)
 			return true;
 		return ether_addr_equal(sdata->vif.addr, hdr->addr1);
