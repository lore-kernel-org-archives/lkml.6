Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoq2fNZgXqvoCC3N6/7+IUzdZQFt8Mgc/LATo1cHibESyR9O9knKpkwTKTYGDtgyFPGJcEa
ARC-Seal: i=1; a=rsa-sha256; t=1527155974; cv=none;
        d=google.com; s=arc-20160816;
        b=W6t1dMHawE7O9sQEuwxeuPkNTlV8IXj8nEE93LnKhf9bZFrD/nQTo4+nhJX71+LPcP
         W5vB9g6D4E0ZpYcbxFfXfNZXJODnSU7/hZJsiXwbGIDGiBugmSDpL0R1XpmEYwYgE0T0
         xn5vKXr4Vb9K2Rrbz1JdzcZxKDM+doLZq7juB+mSKwl9weyJBom6DmyozgSWYv0EgCz4
         UHcr9Uye2fpv/a5GMQrQdnmcBLIn0l9XIxKMSdGxGEmEac6ec2jJO02OH8LPAHUatM45
         Fwee1RYpibhE7E6DLQ/vLsQ0mfQfDvrtM9WiEgADDmzJVPgjest0jjurqtYS/uXAKOlA
         ttLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=jo/ea8/VIw1lW96y/oQXdct0KHE6kWJlsIocgAXg5v4=;
        b=qy+UUy4hgPd3L6AbV9YDvsdKJDmeHyhwqYyiZqyJB1YUrnxo6R9hJ04E65bMvld9Ou
         hCwV2tZZn8rGchhUbENmh6Pz98H6xbfwGsVbAZ7CrtsIG8LPOL9mx9iMMLuhoLie9ftB
         oCdnubuswOmiwJUOMBXu6ZwNWRUgocRc4nemWNl6LogMaVI8s9iczg33bojfmSsNIP19
         NoKDKr/19dh5Xu9CDH+C+1dLa88o9o5VjJzR+dzOhbN2gs3inNCqMIlsTtJUk3UEV5Xg
         li34jb72HwxlE2G9JK05+a7KPD5e7onrR6T40mJgygGaUi6kxAnlMnA99EpMsJEBW30m
         qTJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kS2FxIl5;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kS2FxIl5;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
	Ganesh Goudar <ganeshgr@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 019/161] cxgb4: fix offset in collecting TX rate limit info
Date: Thu, 24 May 2018 11:37:24 +0200
Message-Id: <20180524093020.661919414@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339102854304738?=
X-GMAIL-MSGID: =?utf-8?q?1601339102854304738?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>

[ Upstream commit d775f26b295a0a303f7a73d7da46e04296484fe7 ]

Correct the indirect register offsets in collecting TX rate limit info
in UP CIM logs.

Also, T5 doesn't support these indirect register offsets, so remove
them from collection logic.

Fixes: be6e36d916b1 ("cxgb4: collect TX rate limit info in UP CIM logs")
Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cudbg_entity.h |   28 +++++++---------------
 1 file changed, 9 insertions(+), 19 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_entity.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_entity.h
@@ -419,15 +419,15 @@ static const u32 t6_up_cim_reg_array[][I
 	{0x7b50, 0x7b54, 0x280, 0x20, 0}, /* up_cim_280_to_2fc */
 	{0x7b50, 0x7b54, 0x300, 0x20, 0}, /* up_cim_300_to_37c */
 	{0x7b50, 0x7b54, 0x380, 0x14, 0}, /* up_cim_380_to_3cc */
-	{0x7b50, 0x7b54, 0x2900, 0x4, 0x4}, /* up_cim_2900_to_3d40 */
-	{0x7b50, 0x7b54, 0x2904, 0x4, 0x4}, /* up_cim_2904_to_3d44 */
-	{0x7b50, 0x7b54, 0x2908, 0x4, 0x4}, /* up_cim_2908_to_3d48 */
-	{0x7b50, 0x7b54, 0x2910, 0x4, 0x4}, /* up_cim_2910_to_3d4c */
-	{0x7b50, 0x7b54, 0x2914, 0x4, 0x4}, /* up_cim_2914_to_3d50 */
-	{0x7b50, 0x7b54, 0x2920, 0x10, 0x10}, /* up_cim_2920_to_2a10 */
-	{0x7b50, 0x7b54, 0x2924, 0x10, 0x10}, /* up_cim_2924_to_2a14 */
-	{0x7b50, 0x7b54, 0x2928, 0x10, 0x10}, /* up_cim_2928_to_2a18 */
-	{0x7b50, 0x7b54, 0x292c, 0x10, 0x10}, /* up_cim_292c_to_2a1c */
+	{0x7b50, 0x7b54, 0x4900, 0x4, 0x4}, /* up_cim_4900_to_4c60 */
+	{0x7b50, 0x7b54, 0x4904, 0x4, 0x4}, /* up_cim_4904_to_4c64 */
+	{0x7b50, 0x7b54, 0x4908, 0x4, 0x4}, /* up_cim_4908_to_4c68 */
+	{0x7b50, 0x7b54, 0x4910, 0x4, 0x4}, /* up_cim_4910_to_4c70 */
+	{0x7b50, 0x7b54, 0x4914, 0x4, 0x4}, /* up_cim_4914_to_4c74 */
+	{0x7b50, 0x7b54, 0x4920, 0x10, 0x10}, /* up_cim_4920_to_4a10 */
+	{0x7b50, 0x7b54, 0x4924, 0x10, 0x10}, /* up_cim_4924_to_4a14 */
+	{0x7b50, 0x7b54, 0x4928, 0x10, 0x10}, /* up_cim_4928_to_4a18 */
+	{0x7b50, 0x7b54, 0x492c, 0x10, 0x10}, /* up_cim_492c_to_4a1c */
 };
 
 static const u32 t5_up_cim_reg_array[][IREG_NUM_ELEM + 1] = {
@@ -444,16 +444,6 @@ static const u32 t5_up_cim_reg_array[][I
 	{0x7b50, 0x7b54, 0x280, 0x20, 0}, /* up_cim_280_to_2fc */
 	{0x7b50, 0x7b54, 0x300, 0x20, 0}, /* up_cim_300_to_37c */
 	{0x7b50, 0x7b54, 0x380, 0x14, 0}, /* up_cim_380_to_3cc */
-	{0x7b50, 0x7b54, 0x2900, 0x4, 0x4}, /* up_cim_2900_to_3d40 */
-	{0x7b50, 0x7b54, 0x2904, 0x4, 0x4}, /* up_cim_2904_to_3d44 */
-	{0x7b50, 0x7b54, 0x2908, 0x4, 0x4}, /* up_cim_2908_to_3d48 */
-	{0x7b50, 0x7b54, 0x2910, 0x4, 0x4}, /* up_cim_2910_to_3d4c */
-	{0x7b50, 0x7b54, 0x2914, 0x4, 0x4}, /* up_cim_2914_to_3d50 */
-	{0x7b50, 0x7b54, 0x2918, 0x4, 0x4}, /* up_cim_2918_to_3d54 */
-	{0x7b50, 0x7b54, 0x291c, 0x4, 0x4}, /* up_cim_291c_to_3d58 */
-	{0x7b50, 0x7b54, 0x2924, 0x10, 0x10}, /* up_cim_2924_to_2914 */
-	{0x7b50, 0x7b54, 0x2928, 0x10, 0x10}, /* up_cim_2928_to_2a18 */
-	{0x7b50, 0x7b54, 0x292c, 0x10, 0x10}, /* up_cim_292c_to_2a1c */
 };
 
 static const u32 t6_hma_ireg_array[][IREG_NUM_ELEM] = {
