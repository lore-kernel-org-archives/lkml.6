Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EDAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD33224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD33224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbeKMB61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:58:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726385AbeKMB61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:58:27 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wACG0PLh055344
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:04:34 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nqaw16dm9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:04:34 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 12 Nov 2018 16:04:33 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Nov 2018 16:04:27 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wACG4RSF28704958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 16:04:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F6B8B2064;
        Mon, 12 Nov 2018 16:04:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0F76B2066;
        Mon, 12 Nov 2018 16:04:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.198.12])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Nov 2018 16:04:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 633D616C5D70; Mon, 12 Nov 2018 08:04:25 -0800 (PST)
Date:   Mon, 12 Nov 2018 08:04:25 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH tip/core/rcu 10/41] drivers/ipmi: Replace
 synchronize_sched() with synchronize_rcu()
Reply-To: paulmck@linux.ibm.com
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-10-paulmck@linux.ibm.com>
 <16c19493-44b0-18e3-d3cb-4d6c2f9f9f53@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16c19493-44b0-18e3-d3cb-4d6c2f9f9f53@acm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111216-0064-0000-0000-00000372B1A6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010035; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116418; UDB=6.00577118; IPR=6.00896526;
 MB=3.00024128; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-12 16:04:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111216-0065-0000-0000-00003B4F88FE
Message-Id: <20181112160425.GJ4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 09:38:55AM -0600, Corey Minyard wrote:
> On 11/11/18 1:43 PM, Paul E. McKenney wrote:
> >Now that synchronize_rcu() waits for preempt-disable regions of code
> >as well as RCU read-side critical sections, synchronize_sched() can be
> >replaced by synchronize_rcu().  This commit therefore makes this change.
> 
> Assuming the above is true, this looks fine to me.
> 
> Acked-by: Corey MInyard <cminyard@mvista.com>

Thank you!

> Or I can take it in my tree, either way.

I will carry it unless/until I send it upstream (this coming merge
window) or I see it already upstream.

So your choice.  ;-)

							Thanx, Paul

> -corey
> 
> 
> >Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> >Cc: Corey Minyard <minyard@acm.org>
> >Cc: Arnd Bergmann <arnd@arndb.de>
> >Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >Cc: <openipmi-developer@lists.sourceforge.net>
> >---
> >  drivers/char/ipmi/ipmi_si_intf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> >index 677618e6f1f7..dc8603d34320 100644
> >--- a/drivers/char/ipmi/ipmi_si_intf.c
> >+++ b/drivers/char/ipmi/ipmi_si_intf.c
> >@@ -2187,7 +2187,7 @@ static void shutdown_smi(void *send_info)
> >  	 * handlers might have been running before we freed the
> >  	 * interrupt.
> >  	 */
> >-	synchronize_sched();
> >+	synchronize_rcu();
> >  	/*
> >  	 * Timeouts are stopped, now make sure the interrupts are off
> 
> 

