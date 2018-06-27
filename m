Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A62DC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBB725C5E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBB725C5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964992AbeF0Oe1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:34:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932907AbeF0OeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:34:24 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5RET429122625
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 10:34:23 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jvc4xryk7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 10:34:23 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 27 Jun 2018 10:29:22 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 10:29:19 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5RETIB563111254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 14:29:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EB5BB206A;
        Wed, 27 Jun 2018 10:29:11 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07517B2073;
        Wed, 27 Jun 2018 10:29:11 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jun 2018 10:29:10 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6539416CA20F; Wed, 27 Jun 2018 07:31:25 -0700 (PDT)
Date:   Wed, 27 Jun 2018 07:31:25 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
Reply-To: paulmck@linux.vnet.ibm.com
References: <1529493638-6389-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.1806201528490.16984@chino.kir.corp.google.com>
 <20180621073142.GA10465@dhcp22.suse.cz>
 <2d8c3056-1bc2-9a32-d745-ab328fd587a1@i-love.sakura.ne.jp>
 <20180626170345.GA3593@linux.vnet.ibm.com>
 <20180627072207.GB32348@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627072207.GB32348@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062714-0064-0000-0000-000003210FD3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009264; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053095; UDB=6.00539925; IPR=6.00831019;
 MB=3.00021880; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-27 14:29:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062714-0065-0000-0000-000039BC19A0
Message-Id: <20180627143125.GW3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=755 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 09:22:07AM +0200, Michal Hocko wrote:
> On Tue 26-06-18 10:03:45, Paul E. McKenney wrote:
> [...]
> > 3.	Something else?
> 
> How hard it would be to use a different API than oom notifiers? E.g. a
> shrinker which just kicks all the pending callbacks if the reclaim
> priority reaches low values (e.g. 0)?

Beats me.  What is a shrinker?  ;-)

More seriously, could you please point me at an exemplary shrinker
use case so I can see what is involved?

							Thanx, Paul

