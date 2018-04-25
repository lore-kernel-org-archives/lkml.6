Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZqGrj4fS1pJiTo8xirnRIX6cbqjeZ+OK9n2IPjGmfPdz9ohKbt/FDlZVkGS4i2cm8KYLjRO
ARC-Seal: i=1; a=rsa-sha256; t=1524652856; cv=none;
        d=google.com; s=arc-20160816;
        b=nbNN/6Rxn6xj7/lzMbREcNxv/0SubC277dGZab45QW29RzWN8CN0gPgfotLQLXa2DM
         j8mLD+3dXTHvZpaBy/ytAncqJJqOlrgJE8k35frTxrqsPWM2gD2t0q0wKNCL34bc+UQ5
         5yCH6ZXvOzl/XWPMXOzdKSr3EIcDpy5BYcgHuj7+J+DVOwHBL/fQudwKll1bAjlH5Pl6
         0YjlDXxD2Lv+mu4LdP8Ee5jyjZs2LNyhFM5H+ARakhLrtHXTuLLmTJtO2hk1XkP2Jt4H
         tUF3Yos6JvgCS7jIBmhPLHp1NSHsJDEY+CRBtrP3VEjUNNSKIhwq0YPkO1Z3Aj7wKXHv
         EhUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=05CYZNBOEI2QjlahkmKzvKXxnMH+Dkx7bO0/ovAPoio=;
        b=gOhNJlcah0x2hsGxGKvF3jpOGwyJqJpKRLES6K+0EPIFOJJHdTbH4KuxKKsFUJ9Td2
         Jlju1OmiGZ6BaqXjX6oz9PVW3cxaEQl/7HdIof5A9ftOK07utC3vY83z3D4JEwkWPNS6
         mryVONxC7Obj/YwppAOXB7cMYXdMQEvmv+0Ivjg7hsPcYP2bwna8QHq2ioceiidsHH0G
         iSWJxhk7km/LhlAzlRPvZ9g1AKZ2Xq1agkq0riDcGjWZQZ4TaxhSbjnpy1BlujIxAzfm
         3EVJB8d9Yg0jCLjS27CxDRvnFlEfzfKWp4V6psCYXPXW6yafvHUdbXiUZn8CUipOzEYW
         RXlA==
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
Subject: [PATCH 4.14 094/183] i40e: program fragmented IPv4 filter input set
Date: Wed, 25 Apr 2018 12:35:14 +0200
Message-Id: <20180425103246.253088598@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714393710376373?=
X-GMAIL-MSGID: =?utf-8?q?1598714393710376373?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>


[ Upstream commit 02b4016bfe43d2d5ed043be7ffa56cda6a4d1100 ]

When implementing support for IP_USER_FLOW filters, we correctly
programmed a filter for both the non fragmented IPv4/Other filter, as
well as the fragmented IPv4 filters. However, we did not properly
program the input set for fragmented IPv4 PCTYPE. This meant that the
filters would almost certainly not match, unless the user specified all
of the flow types.

Add support to program the fragmented IPv4 filter input set. Since we
always program these filters together, we'll assume that the two input
sets must match, and will thus always program the input sets to the same
value.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |   10 ++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c    |    3 +++
 2 files changed, 13 insertions(+)

--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3648,6 +3648,16 @@ static int i40e_check_fdir_input_set(str
 
 	i40e_write_fd_input_set(pf, index, new_mask);
 
+	/* IP_USER_FLOW filters match both IPv4/Other and IPv4/Fragmented
+	 * frames. If we're programming the input set for IPv4/Other, we also
+	 * need to program the IPv4/Fragmented input set. Since we don't have
+	 * separate support, we'll always assume and enforce that the two flow
+	 * types must have matching input sets.
+	 */
+	if (index == I40E_FILTER_PCTYPE_NONF_IPV4_OTHER)
+		i40e_write_fd_input_set(pf, I40E_FILTER_PCTYPE_FRAG_IPV4,
+					new_mask);
+
 	/* Add the new offset and update table, if necessary */
 	if (new_flex_offset) {
 		err = i40e_add_flex_offset(&pf->l4_flex_pit_list, src_offset,
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5828,6 +5828,9 @@ static void i40e_fdir_filter_exit(struct
 	/* Reprogram the default input set for Other/IPv4 */
 	i40e_write_fd_input_set(pf, I40E_FILTER_PCTYPE_NONF_IPV4_OTHER,
 				I40E_L3_SRC_MASK | I40E_L3_DST_MASK);
+
+	i40e_write_fd_input_set(pf, I40E_FILTER_PCTYPE_FRAG_IPV4,
+				I40E_L3_SRC_MASK | I40E_L3_DST_MASK);
 }
 
 /**
