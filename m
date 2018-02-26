Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226THMRlg+Hyqf1ZRpMhs39nycB29arCr1/EaF2/OpOwefWc5FGJH8X3joW6UJd/hLy3fpmr
ARC-Seal: i=1; a=rsa-sha256; t=1519676923; cv=none;
        d=google.com; s=arc-20160816;
        b=ML8oDbDyoZIUKgdvlao0DN6vTyhLvRkWIiHCNBXERlgUHg6SS+QvlwkmXwss3FXSRS
         8HLW60pqAB+sHyjwZkWaHvIt0TcUuAW84oDGogTkbGE7WTqKbrAnCebyYXwjwhGW0No5
         T0vV3/rUiqWcQrJl9C3xQH69vf9CQluT3+dMIOyrtn9cZDiTLxmTGEwPxwQjXmmQwUCj
         tR4WYsENtsi/r/RgydDIuR5xbVC6cUrHDe/OXp1x+GHztXyY5X+myrhywhbPjCw2PYvA
         2KwevdjvopnU30e2TtATnKVZpL0wWv2UTWvUuOxVQMpA/QQ2jlSHIHNpykVxrKf/txhl
         Q8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Nh9WfisT5Wbh/MpzEeFYh+RC4nkXsRVsVD/tpJJ41Xk=;
        b=RKdHHpqxcdNnAvQem4wIyQbMj3IPAZtjqnokbZvAlpOejCFy4gsf3TZE3Ete+WjP30
         IkUYvRWxELldSgz+/uYRdNSNgnxoGCCNIYLkfcwpFNNw+cPjT1BNFw5IT4eakMoL/m9R
         JQEY0ehiOCM3nfoQ4/58cSnBswmUeKi6iq09/QGEwCI4tCP/Oo4WbP+M84lP9NJeranm
         WSh74veLEBIDcaa2mgnFQgoX09grVyH9c1+KFotB29MywSIyE1PAbutCwyM+6bCcrGXJ
         PuFqaXRpzcB6Tvj76nz89q/AzcunguEX8dCWeT2FnYfslSTgzVOs0vgzWe/+N9yWNdw9
         /8gw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.15 58/64] drm/amdgpu: Add dpm quirk for Jet PRO (v2)
Date: Mon, 26 Feb 2018 21:22:35 +0100
Message-Id: <20180226202155.921751634@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496533849968794?=
X-GMAIL-MSGID: =?utf-8?q?1593496749706605592?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit f2e5262f75ecb40a6e56554e156a292ab9e1d1b7 upstream.

Fixes stability issues.

v2: clamp sclk to 600 Mhz

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=103370
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/si_dpm.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -3464,6 +3464,11 @@ static void si_apply_state_adjust_rules(
 		    (adev->pdev->device == 0x6667)) {
 			max_sclk = 75000;
 		}
+		if ((adev->pdev->revision == 0xC3) ||
+		    (adev->pdev->device == 0x6665)) {
+			max_sclk = 60000;
+			max_mclk = 80000;
+		}
 	} else if (adev->asic_type == CHIP_OLAND) {
 		if ((adev->pdev->revision == 0xC7) ||
 		    (adev->pdev->revision == 0x80) ||
