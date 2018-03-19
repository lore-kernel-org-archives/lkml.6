Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsR6Xsj07pv1YuKCghjjqSpGqbBD9c5/955sw2vNOjcRSfbQYNe1hNjqssIIfz9ilTBDOSN
ARC-Seal: i=1; a=rsa-sha256; t=1521483137; cv=none;
        d=google.com; s=arc-20160816;
        b=uTa9Gfh77ANGv0THKRP/GacwOctPkCkjU+KR+B8DKtfSCEchr8H5gxQHEY9M5ulLzm
         Q6CuKkB1fdh1yeoGR4PJp4qwi6bIsOch1nx1vlYqv0JUaS60spsk3+vdZwzENfGErT+a
         U8TGCwY8GCzvvgUrF7AK7VhGf9TFtRLUdeq4YJwLzpv5y4/ywyYmimIJxLWRgQlhNyUx
         2NhxzDXArlTB9znsoQR8LxGB5nNJAGZFhkQ3P7+Pb+vd3jrmess4NmqA1pXuE4uKmeSh
         w3P1kZA9s7ZNlIWN6DHmnLE+ug2V7ZAekZmSxr0FeTtHD3u7hupdtN+0Qc7Lg0uYbKs3
         xSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uplXriAQqnUdzM3c4jhsKhtm2OxoJpiOPQ6VZfUbndg=;
        b=xu47siboUIAxSyf6LEv7b2CDLZeJBPcc3M3ZufIq8vWlZ+SsTyqsIDUZsPyE9KYrxw
         i93tAE6bFcqp3SwDhvRo3Rv2O+gJ4GRWGTCSq5OuMjoP+OeOrokt3zR7fn7AA4v0vfSk
         DkTcG5c1Vn2/sKCij2GCh8jK6PZmzBYpG6px8mwqmwAGpPMqreGkNhbyohj5j6yKJe7c
         IiRmhg1lKeO+3NYI/yqxIVqMbn9IaDPn+lFs6VF+TXSCll86T4z7Hxy5sW8fkL08SF0z
         qnyePQVSA40F6AgAZnHu19KBpNF2SFqmSg4/ScR700poP9+OjMnh27aSGBNN2Ru18WzN
         w3vA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lihong Yang <lihong.yang@intel.com>,
	Andrew Bowers <andrewx.bowers@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 013/134] i40e: fix ethtool to get EEPROM data from X722 interface
Date: Mon, 19 Mar 2018 19:04:56 +0100
Message-Id: <20180319171851.013194578@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390702253107464?=
X-GMAIL-MSGID: =?utf-8?q?1595390702253107464?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lihong Yang <lihong.yang@intel.com>


[ Upstream commit c271dd6c391b535226cf1a81aaad9f33cb5899d3 ]

Currently ethtool -e will error out with a X722 interface
as its EEPROM has a scope limit at offset 0x5B9FFF.
This patch fixes the issue by setting the EEPROM length to
the scope limit to avoid NVM read failure beyond that.

Change-ID: I0b7d4dd6c7f2a57cace438af5dffa0f44c229372
Signed-off-by: Lihong Yang <lihong.yang@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1073,6 +1073,11 @@ static int i40e_get_eeprom_len(struct ne
 	struct i40e_hw *hw = &np->vsi->back->hw;
 	u32 val;
 
+#define X722_EEPROM_SCOPE_LIMIT 0x5B9FFF
+	if (hw->mac.type == I40E_MAC_X722) {
+		val = X722_EEPROM_SCOPE_LIMIT + 1;
+		return val;
+	}
 	val = (rd32(hw, I40E_GLPCI_LBARCTRL)
 		& I40E_GLPCI_LBARCTRL_FL_SIZE_MASK)
 		>> I40E_GLPCI_LBARCTRL_FL_SIZE_SHIFT;
