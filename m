Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELthvgKOnr21G6P2ix+jp9JBclXPK8gaf6KfbdB73+NW2NRQ4T8U0MnQ7MjbhjiZl3SzKTIj
ARC-Seal: i=1; a=rsa-sha256; t=1521483554; cv=none;
        d=google.com; s=arc-20160816;
        b=qxWmDYIELpEempOk0wZ0wb/v57RO4PZ7mkWmXO37bw2elajuiE7reSop+AqCd2rGcJ
         PDTTNwwGUtg7kJ1UV6wHmiKQb9+CGZGVMJhzpI4K1AjxeLuuP2VcFYyuyO4SAvAwonVs
         UtsN+39eXr091DI2b2NXkXImv/4LDHznj5tLoj3mmtAzvT7CU6f2BOQI3Vfb/ZVm5bdc
         T8FgevZQL5+9DnKcPgHjDfoy763YjlJT4u1cHeioOwGW8STuH8uhLIDgMniPTxZptkGR
         ECtVpGUGaxiGewEWubhRFEQrsdIKHWHFeo0SZKgZ5ty5jTQTqKlHmPSfDmjExC7pXoh6
         Dzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RoKS40n2hHCV+Tt0kmZLbtJuD1otOAVfcY6+qKvI3QU=;
        b=DaHB0GSWZ7wpp50qDGXVRfK2qa4nunEklxg+JfoIWGSF9KDe9EykxZKQCVXKnQYoku
         +MU9q57JSPH/OlK/S16thOUyG0oAhK+HSDDaHJPaOHvtW09Q32Q84Vn5FQdRzbWRSnYF
         mXSZGuKBWjEm1eoRRtwlmPhVaBHTS1gO+di2v279+jw3WIBdC63N40eXqxwqm04NH5Jh
         E3jsYlvk0RsBJYqMEZP6R7k9AND0vAorWIzzhXstup+kMteEdJ1iPai9MBXpDi2k+els
         qYIne5P7DNVqgk8T0r26w0w/akQZ5EFeVofobpFlzhKTd4TVbgJxQLjF1BZDY5O25EF2
         /GWQ==
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
Subject: [PATCH 4.9 024/241] i40e: Acquire NVM lock before reads on all devices
Date: Mon, 19 Mar 2018 19:04:49 +0100
Message-Id: <20180319180752.169330146@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390699398049231?=
X-GMAIL-MSGID: =?utf-8?q?1595391139777225767?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
