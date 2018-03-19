Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsSKsNMAVbFNQFxsJX33X5ZMYtuAxp0cKLGxSpq5wvfiwVkL7ob/bxEfu2L2oYQh2wT+oVr
ARC-Seal: i=1; a=rsa-sha256; t=1521483134; cv=none;
        d=google.com; s=arc-20160816;
        b=0hb46pgQon7BgPW91w+mk0LaePLP9WnKr4+ZFi1Izt86+BwpKKhljGlQ1VPUJ2Dezs
         hN+rOQx+d20PJZQ/cdLEntxpeFELtO40UB3v2e/R1vyAzXTU2y0vV27GwPvL0uuf4289
         kBNBdZHThQYdF8aE8s5j9zU2vizM1y0TkBZHGJHORcId9V0yoH0aT7MOlmInvIv5ySfM
         BNeY+0HttfFagjZwJ3ukAPycKP3qK5cLgKPZ6XqkAo+GWzzaFBJoAxhsbyljbx9MhEQC
         d59ppPkk3lSL4B01uqSXgx5p0n5ghtGUub9Buane2LT8TIwc/tRZXkdlnp8q378pkRMA
         /ayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=q9wQmnurLZKm/QZDD5BH+KGAVHfN8bk5yGx2A+IYLvI=;
        b=N0UM1JrsxatiV2vnNDj3sHgbSFlbi6v4vxpUmjr6jLjEo4JwUuPK98Luo+f47XgjWR
         HM1OkRLYbhSkomhACPkC3Jc6sRKwavKHcrG+Wa0OOSoHosvtYgaanmX/sYte5Jw2rwjr
         BTxGnPnLdGdKXMqpcGuVSlSgEBMdSwz30GRkaxotKruTuo0xPId3tM3HT0qELxGYSmDd
         cV1Tz4jbGXY4RLBa9icDtbTL3qX20PNKKnpGqQDlrDq43c1UnzLCD/TLdDKWmUYd38PV
         Jjn4WQRy4qvait7vILtWCm2+LxfME8kjFOviw8k/6wgDeIvBt3cuAISO94mmhB+s4cW4
         dOYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Aaron Salter <aaron.k.salter@intel.com>,
	Andrew Bowers <andrewx.bowers@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 012/134] i40e: Acquire NVM lock before reads on all devices
Date: Mon, 19 Mar 2018 19:04:55 +0100
Message-Id: <20180319171850.885199227@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390699398049231?=
X-GMAIL-MSGID: =?utf-8?q?1595390699398049231?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Salter <aaron.k.salter@intel.com>


[ Upstream commit 96a39aed25e6559b160786117df124084feb9080 ]

Acquire NVM lock before reads on all devices.  Previously, locks were
only used for X722 and later.  Fixes an issue where simultaneous X710
NVM accesses were interfering with each other.

Change-ID: If570bb7acf958cef58725ec2a2011cead6f80638
Signed-off-by: Aaron Salter <aaron.k.salter@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -292,14 +292,14 @@ i40e_status i40e_read_nvm_word(struct i4
 {
 	enum i40e_status_code ret_code = 0;
 
-	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE) {
-		ret_code = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
-		if (!ret_code) {
+	ret_code = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
+	if (!ret_code) {
+		if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE) {
 			ret_code = i40e_read_nvm_word_aq(hw, offset, data);
-			i40e_release_nvm(hw);
+		} else {
+			ret_code = i40e_read_nvm_word_srctl(hw, offset, data);
 		}
-	} else {
-		ret_code = i40e_read_nvm_word_srctl(hw, offset, data);
+		i40e_release_nvm(hw);
 	}
 	return ret_code;
 }
