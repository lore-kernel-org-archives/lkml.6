Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbeBBPqg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:46:36 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:44299 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbeBBPq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:46:26 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Harish Patil <harish.patil@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Dept-GELinuxNICDev@cavium.com
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Johannes Berg <johannes.berg@intel.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: qlge: use memmove instead of skb_copy_to_linear_data
Date: Fri,  2 Feb 2018 16:45:44 +0100
Message-Id: <20180202154603.1617656-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:9q+rPD9waH88miPclfQ1JS6GGwoqURaUWHMwaLLAjvcq/LcsZHu
 p+slRz23i9KEdbdJ+XcuEARLK2/UoDjJdL1OI+nv7yJdNOj9Zqxhmwln88qyf9oNGhGilRq
 AvZr7B86rYkhlX0/JFl/KsTQOW0zcePr8W6cLDl7aFJ0l049GvAONf9lGnL12IoBmkj7ONb
 W0uoR/nlHIpXLzYmo5ZxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f77pR6Nk46k=:12K0bgQOWTv/wFZD3jiQqd
 MfXejreBjWtKhuh3AdBR2bFZzIQy0r/6BpWx5ZvSehrK+QQa/6M0mlGGjpIfGHJbXOG2kUdjy
 MR8e6EGODU3A3EKyPXW0epiBOrVVUwrGmM4r4ZW+UtgQfbyO8BJkT5yJanNd56kN8ibue1sH6
 seD5WpqDSEE0SZqqPcuzai/SFgNSeDAbaclUSvG5nUCkDOQWFJjUvUcbLK/cbw6QnCo4vImKt
 Ta3j+OOUMfY9a+sFKwfsX3fZHLhn22AUUo7vi8XnWqPS40J+G2RwSwwYB1NSfiQsFRZCNAkVv
 01ehr3SVL7+7KfvE21MHsRYlZhi9w4qcVoiSVaFDYYkn9t7V2WoO504TC2UrTi2vq9nJYn7/2
 DQLyBSUyvxcmhqqan7ZAQeam0I27S5EFvFs/YJPtBCi946h7IvCGjqDNKB0EOypTdZTe2Gf+5
 PkScyHPuCnjxS8dmKw1T7LpxwPtYwf2jQ7z4jtMxdYRSjflVgVbFq7C6edunCb/yxdikt6w4c
 4l8hL5rZR7IeUj5yRffnkbt9yGdulTeT2ZYb5B55fXMg+sd0isHZtHm9J6F/Cv5qgXWOKaKUs
 Ci+XfbsBEUUrv/c7Gml7nXasimf3/R7kUVWFxxESJ3nNt7ZzhMmLnA6NC6zF1mU57Uc08VLYW
 qDly6QJ/fdpSMkW8/L2QTejeFag+zoVnx/b0heUmHgEF0EJb0NURbQ6DCI00mMfqIm2dpckJv
 MnfCf7UIEs3o3kYODvOh/pjpJVQUlN+YJnmdDg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-8 points out that the skb_copy_to_linear_data() argument points to
the skb itself, which makes it run into a problem with overlapping
memcpy arguments:

In file included from include/linux/ip.h:20,
                 from drivers/net/ethernet/qlogic/qlge/qlge_main.c:26:
drivers/net/ethernet/qlogic/qlge/qlge_main.c: In function 'ql_realign_skb':
include/linux/skbuff.h:3378:2: error: 'memcpy' source argument is the same as destination [-Werror=restrict]
  memcpy(skb->data, from, len);

It's unclear to me what the best solution is, maybe it ought to use a
different helper that adjusts the skb data in a safe way. Simply using
memmove() here seems like the easiest workaround.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/qlogic/qlge/qlge_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlge/qlge_main.c b/drivers/net/ethernet/qlogic/qlge/qlge_main.c
index 7b97a9969046..50038d946ced 100644
--- a/drivers/net/ethernet/qlogic/qlge/qlge_main.c
+++ b/drivers/net/ethernet/qlogic/qlge/qlge_main.c
@@ -1747,8 +1747,7 @@ static void ql_realign_skb(struct sk_buff *skb, int len)
 	 */
 	skb->data -= QLGE_SB_PAD - NET_IP_ALIGN;
 	skb->tail -= QLGE_SB_PAD - NET_IP_ALIGN;
-	skb_copy_to_linear_data(skb, temp_addr,
-		(unsigned int)len);
+	memmove(skb->data, temp_addr, len);
 }
 
 /*
-- 
2.9.0
