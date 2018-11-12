Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C797FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A8F2245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A8F2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbeKMDCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:02:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727732AbeKMDCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:02:01 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wACH7OkH008532
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 12:07:52 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nqd0yj323-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 12:07:51 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 12 Nov 2018 17:07:51 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Nov 2018 17:07:45 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wACH7iro26280074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 17:07:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23028B2064;
        Mon, 12 Nov 2018 17:07:44 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E71ACB206A;
        Mon, 12 Nov 2018 17:07:43 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.198.12])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Nov 2018 17:07:43 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B108416C3418; Mon, 12 Nov 2018 09:07:42 -0800 (PST)
Date:   Mon, 12 Nov 2018 09:07:42 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Edward Cree <ecree@solarflare.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Lance Roy <ldr709@gmail.com>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH tip/core/rcu 2/7] sfc: Replace spin_is_locked() with
 lockdep
Reply-To: paulmck@linux.ibm.com
References: <20181111200421.GA10551@linux.ibm.com>
 <20181111200443.10772-2-paulmck@linux.ibm.com>
 <d5a895b9-6d0b-1d51-dc97-96864c5335af@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5a895b9-6d0b-1d51-dc97-96864c5335af@solarflare.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111217-0068-0000-0000-0000035ED551
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010035; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116439; UDB=6.00578989; IPR=6.00896547;
 MB=3.00024129; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-12 17:07:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111217-0069-0000-0000-00004666B98C
Message-Id: <20181112170742.GP4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 01:02:32PM +0000, Edward Cree wrote:
> On 11/11/18 20:04, Paul E. McKenney wrote:
> > From: Lance Roy <ldr709@gmail.com>
> >
> > lockdep_assert_held() is better suited to checking locking requirements,
> > since it only checks if the current thread holds the lock regardless of
> > whether someone else does. This is also a step towards possibly removing
> > spin_is_locked().
> >
> > Signed-off-by: Lance Roy <ldr709@gmail.com>
> > Cc: Solarflare linux maintainers <linux-net-drivers@solarflare.com>
> > Cc: Edward Cree <ecree@solarflare.com>
> > Cc: Bert Kenward <bkenward@solarflare.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: <netdev@vger.kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > ---
> Acked-by: Edward Cree <ecree@solarflare.com>

Applied, thank you!

							Thanx, Paul

> >  drivers/net/ethernet/sfc/efx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> > index 98fe7e762e17..3643015a55cf 100644
> > --- a/drivers/net/ethernet/sfc/efx.c
> > +++ b/drivers/net/ethernet/sfc/efx.c
> > @@ -3167,7 +3167,7 @@ struct hlist_head *efx_rps_hash_bucket(struct efx_nic *efx,
> >  {
> >  	u32 hash = efx_filter_spec_hash(spec);
> >  
> > -	WARN_ON(!spin_is_locked(&efx->rps_hash_lock));
> > +	lockdep_assert_held(&efx->rps_hash_lock);
> >  	if (!efx->rps_hash_table)
> >  		return NULL;
> >  	return &efx->rps_hash_table[hash % EFX_ARFS_HASH_TABLE_SIZE];
> 
> 

