Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeBBQWJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:22:09 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:52550 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeBBQVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:21:22 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andi Kleen <ak@linux.intel.com>
Cc: Nicolas Pitre <nico@linaro.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/7] [HACK] avoid gcc-8 ICE on LTO
Date: Fri,  2 Feb 2018 17:21:02 +0100
Message-Id: <20180202162104.2300532-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180202161550.2106846-1-arnd@arndb.de>
References: <20180202161550.2106846-1-arnd@arndb.de>
X-Provags-ID: V03:K0:iSnERfIOGrKHLp2wtMzu2l3E4eXo2wWCjWpmjszVxdjKWYTgF3l
 JTIOIS6ASiA4lXy2N8ugZVQ1YtUalhqZ98YxuCR5ezrGvjT+LegM3AmHxSxx0bMH/NP3esB
 7FTrndiceL4mGnHIi97qgFY3WSV3g3/7VKp48hPjuV4GHoqPYqiHY8rBBprf5tcyqFGsWUg
 9ho6l6RzZPpT4rnxN2r4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gUJgnlzJwVQ=:8Kircma9Rd3ErCZW+9N4+H
 xvjP1oBVPMZlMrcklGoYfPRKh/CTbFEcrRlCBm9VfeTDfmaAfoc3OjNJ4XPw+e6UInBPcPHGl
 xPomcl8xHtyaZI8Nd8KdDg6/GzZ9PrryK/6xkwS7xt2sWBVVrkYUWuhpUB2SsyKpAw2vVStYA
 JJxzwCUhrnLI6R1iuThH6q/dZOTWslcWvkKmB4qx4ZEGpczHW1XGwJHwhApsBHuC/899ydUkx
 8ux+k2eFvWUOCQBjbFarMBd19Q1+v23fPZ5qxqClj9ihA3KgvBpOPmVW6TWwGIOMdn6u0bgbB
 jIhQ9Z813h4BOYV/1NSxLXzA0B+aUow+g+kWiW3+9+WLc8Dh+8mhNmcUu0QL/lqirD2MaVf+C
 yap2On8oFqNSH3qdOm+trmNcaqaJ0OnqG5G3J/zIGFydEwW66IhZl+ZOqYA9en/RnzLG2pYqO
 0E8yWEFObFSuyfQO6SMTY+BC0xAGqAgSwtkA5KowkkncSfwdAEJUt2edthubbIEGQJtcNNHvn
 aqjbnpGW1hSPMJAtrSPxfRG9xLAYxc2krgv48OoT89HYka6LSwHGF7bHQCmQKosXgiwwi9KaG
 UkiuXzzSSp2UvEVFmEVYdFGA05HdXxSawyf6sCig7SXutjNCphM14BO+fWD2kIHfZbqmhUmef
 pBy4DGiN+nju01Nb2grDkzikhFURoQrDcvib/YPI8MVrFeIjd/nmthItXkvkWSGCTV13K3HQx
 AEyO03NhALcHJQL7ss8+G4iBZNGi53niZ/0Duw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into a build error:

/git/arm-soc/net/sctp/sm_sideeffect.c: In function 'sctp_do_sm':
/git/arm-soc/net/sctp/sm_sideeffect.c:1155:5: internal compiler error: Segmentation fault
 int sctp_do_sm(struct net *net, enum sctp_event event_type,
     ^
0xa42b7f crash_signal

The bug is fixed in mainline gcc now, but I carry this as I have
not yet upgrade.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84105
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/sctp/sm_sideeffect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
index b71e7fb0a20a..d211863fad48 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -1152,12 +1152,12 @@ static void sctp_cmd_send_asconf(struct sctp_association *asoc)
  * If you want to understand all of lksctp, this is a
  * good place to start.
  */
+typedef const char *(printfn_t)(union sctp_subtype);
 int sctp_do_sm(struct net *net, enum sctp_event event_type,
 	       union sctp_subtype subtype, enum sctp_state state,
 	       struct sctp_endpoint *ep, struct sctp_association *asoc,
 	       void *event_arg, gfp_t gfp)
 {
-	typedef const char *(printfn_t)(union sctp_subtype);
 	static printfn_t *table[] = {
 		NULL, sctp_cname, sctp_tname, sctp_oname, sctp_pname,
 	};
-- 
2.9.0
