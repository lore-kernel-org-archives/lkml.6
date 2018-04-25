Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+8TXvXwEGmSKRZijcLH6AVNq+g9p25fkn8PObl9k2jy8Op5liigZ5qo6cn2h4VHjYqas2m
ARC-Seal: i=1; a=rsa-sha256; t=1524652859; cv=none;
        d=google.com; s=arc-20160816;
        b=KlPlKwn2m32rGEu3bEHX4Yav9soAUs5UdkpOILuTc45xbedyY/oUp/t9cZ6oQ2LlQX
         5kKUrO4YwLP9RrkJEZiK5fS/psX2gx09GesMW+VGxUN0t0zOeaTSy/kVM+Mj1KKjWAlP
         sxjoEmq1tVzuYtnCLUmE1HptsHQ9J+030zjW1TIw9liRl6iJJpNwsH9kcUqjPQA2w6pI
         239KQraHlogkLDHRGoghPixx8X0jg2q2xz1zTdg9X9jMivnG3X/n6Ub3wcb+H5Lxst49
         k99t619GGp58KrH8FhYYHsqsTkRo4VicRB/kkC09RwyVjQs1CrVnRmqgWtzmxIrzNFN+
         bHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FhgKPJs/NBCbE+wo84KcsjMaPRBV9nHVrmNtErZQcwQ=;
        b=ekuDTtIvcJRi885f0A3pl7MQbUBs80PoIxZ5pn2lZxSqJDzzbwhIboJV5vyPM2MD7o
         06CMmVEFgnda0ccN45CIlciq1RjUFt/8TDJ3TwLagzwN0WY9jw9aSEKVxPVEm01PTOg/
         pyBUH0Q7xFJNztLiFU7nKu6+Di6bAR8TZCls20dTGp0zXW2/YeoZion563KX89fSDbFy
         slTnqSjeev2odnjOS4kCL2hiVQCTnrVvLf6ZCcwgmBuJBuptUP+Pl612XvJVohNoW+ef
         DdFObhLe1tRxZtRWcs3JXbbDcfA/Jmq+PtXUqEaH8V5aPvJ9dYhaOEKPXEHsxRoZP07u
         NZ0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Bowers <andrewx.bowers@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 095/183] i40e: fix reported mask for ntuple filters
Date: Wed, 25 Apr 2018 12:35:15 +0200
Message-Id: <20180425103246.288420349@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714396261289230?=
X-GMAIL-MSGID: =?utf-8?q?1598714396261289230?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>


[ Upstream commit 40339af33c703bacb336493157d43c86a8bf2fed ]

In commit 36777d9fa24c ("i40e: check current configured input set when
adding ntuple filters") some code was added to report the input set
mask for a given filter when reporting it to the user.

This code is necessary so that the reported filter correctly displays
that it is or is not masking certain fields.

Unfortunately the code was incorrect. Development error accidentally
swapped the mask values for the IPv4 addresses with the L4 port numbers.
The port numbers are only 16bits wide while IPv4 addresses are 32 bits.
Unfortunately we assigned only 16 bits to the IPv4 address masks.
Additionally we assigned 32bit value 0xFFFFFFF to the TCP port numbers.
This second part does not matter as the value would be truncated to
16bits regardless, but it is unnecessary.

Fix the reported masks to properly report that the entire field is
masked.

Fixes: 36777d9fa24c ("i40e: check current configured input set when adding ntuple filters")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2588,16 +2588,16 @@ static int i40e_get_ethtool_fdir_entry(s
 
 no_input_set:
 	if (input_set & I40E_L3_SRC_MASK)
-		fsp->m_u.tcp_ip4_spec.ip4src = htonl(0xFFFF);
+		fsp->m_u.tcp_ip4_spec.ip4src = htonl(0xFFFFFFFF);
 
 	if (input_set & I40E_L3_DST_MASK)
-		fsp->m_u.tcp_ip4_spec.ip4dst = htonl(0xFFFF);
+		fsp->m_u.tcp_ip4_spec.ip4dst = htonl(0xFFFFFFFF);
 
 	if (input_set & I40E_L4_SRC_MASK)
-		fsp->m_u.tcp_ip4_spec.psrc = htons(0xFFFFFFFF);
+		fsp->m_u.tcp_ip4_spec.psrc = htons(0xFFFF);
 
 	if (input_set & I40E_L4_DST_MASK)
-		fsp->m_u.tcp_ip4_spec.pdst = htons(0xFFFFFFFF);
+		fsp->m_u.tcp_ip4_spec.pdst = htons(0xFFFF);
 
 	if (rule->dest_ctl == I40E_FILTER_PROGRAM_DESC_DEST_DROP_PACKET)
 		fsp->ring_cookie = RX_CLS_FLOW_DISC;
