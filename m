Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AB0C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9483242D7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9483242D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbeFVNhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:37:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750853AbeFVNhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:37:08 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MDYIpg078016
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 09:37:07 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jry4sy9ua-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 09:37:07 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 09:37:06 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Jun 2018 09:37:02 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5MDb1Zx16515510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jun 2018 13:37:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49CB6B206C;
        Fri, 22 Jun 2018 09:37:01 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E45BDB206A;
        Fri, 22 Jun 2018 09:37:00 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.197.125])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Jun 2018 09:37:00 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C984016C9E49; Fri, 22 Jun 2018 06:39:03 -0700 (PDT)
Date:   Fri, 22 Jun 2018 06:39:03 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Byungchul Park <byungchul.park@lge.com>, kbuild-all@01.org,
        jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, joel@joelfernandes.org
Subject: Re: [PATCH] rcu: Refactor rcu_{nmi,irq}_{enter,exit}()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1529647926-24427-1-git-send-email-byungchul.park@lge.com>
 <201806221642.HoutHCRt%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201806221642.HoutHCRt%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062213-0060-0000-0000-000002812DD2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009238; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01050688; UDB=6.00538477; IPR=6.00829658;
 MB=3.00021805; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-22 13:37:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062213-0061-0000-0000-00004589FF24
Message-Id: <20180622133903.GP3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806220152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 04:34:48PM +0800, kbuild test robot wrote:
> Hi Byungchul,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on rcu/rcu/next]
> [also build test WARNING on v4.18-rc1 next-20180622]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Byungchul-Park/rcu-Refactor-rcu_-nmi-irq-_-enter-exit/20180622-141334
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> reproduce: make htmldocs
> 
> All warnings (new ones prefixed by >>):
> 
>    WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
> >> kernel/rcu/tree.c:778: warning: Function parameter or member 'irq' not described in 'rcu_nmi_exit_common'
> >> kernel/rcu/tree.c:938: warning: Function parameter or member 'irq' not described in 'rcu_nmi_enter_common'

It is complaining about the docbook function-header comment.  It wants
the "irq" parameter described, something like this:

 * @irq: Is this call from rcu_irq_enter?

And similar for rcu_nmi_exit_common().

							Thanx, Paul

>    include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.ibss' not described in 'wireless_dev'
>    include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.connect' not described in 'wireless_dev'
>    include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.keys' not described in 'wireless_dev'
>    include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.ie' not described in 'wireless_dev'
>    include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.ie_len' not described in 'wireless_dev'
>    include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.bssid' not described in 'wireless_dev'
>    include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.ssid' not described in 'wireless_dev'
>    include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.default_key' not described in 'wireless_dev'
>    include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.default_mgmt_key' not described in 'wireless_dev'
>    include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.prev_bssid_valid' not described in 'wireless_dev'
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2282: warning: Function parameter or member 'radiotap_timestamp.units_pos' not described in 'ieee80211_hw'
>    include/net/mac80211.h:2282: warning: Function parameter or member 'radiotap_timestamp.accuracy' not described in 'ieee80211_hw'
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:955: warning: Function parameter or member 'control.rates' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'control.rts_cts_rate_idx' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'control.use_rts' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'control.use_cts_prot' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'control.short_preamble' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'control.skip_table' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'control.jiffies' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'control.vif' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'control.hw_key' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'control.flags' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'control.enqueue_time' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'ack' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'ack.cookie' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'status.rates' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'status.ack_signal' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'status.ampdu_ack_len' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'status.ampdu_len' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'status.antenna' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'status.tx_time' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'status.is_valid_ack_signal' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'status.status_driver_data' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'driver_rates' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'pad' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:955: warning: Function parameter or member 'rate_driver_data' not described in 'ieee80211_tx_info'
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
>    include/net/mac80211.h:2083: warning: bad line: >
> 
> vim +778 kernel/rcu/tree.c
> 
> 19dd1591f kernel/rcutree.c  Frederic Weisbecker 2012-06-04  765  
> 19dd1591f kernel/rcutree.c  Frederic Weisbecker 2012-06-04  766  /**
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  767   * rcu_nmi_exit_common - inform RCU of exit from NMI context
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  768   *
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  769   * If we are returning from the outermost NMI handler that interrupted an
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  770   * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nmi_nesting
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  771   * to let the RCU grace-period handling know that the CPU is back to
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  772   * being RCU-idle.
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  773   *
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  774   * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  775   * with CONFIG_RCU_EQS_DEBUG=y.
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  776   */
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  777  static __always_inline void rcu_nmi_exit_common(bool irq)
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02 @778  {
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  779  	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  780  
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  781  	/*
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  782  	 * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  783  	 * (We are exiting an NMI handler, so RCU better be paying attention
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  784  	 * to us!)
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  785  	 */
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  786  	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting <= 0);
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  787  	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  788  
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  789  	/*
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  790  	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  791  	 * leave it in non-RCU-idle state.
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  792  	 */
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  793  	if (rdtp->dynticks_nmi_nesting != 1) {
> dec98900e kernel/rcu/tree.c Paul E. McKenney    2017-10-04  794  		trace_rcu_dyntick(TPS("--="), rdtp->dynticks_nmi_nesting, rdtp->dynticks_nmi_nesting - 2, rdtp->dynticks);
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  795  		WRITE_ONCE(rdtp->dynticks_nmi_nesting, /* No store tearing. */
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  796  			   rdtp->dynticks_nmi_nesting - 2);
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  797  		return;
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  798  	}
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  799  
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  800  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> dec98900e kernel/rcu/tree.c Paul E. McKenney    2017-10-04  801  	trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nmi_nesting, 0, rdtp->dynticks);
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  802  	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  803  
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  804  	if (irq)
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  805  		rcu_prepare_for_idle();
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  806  
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  807  	rcu_dynticks_eqs_enter();
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  808  
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  809  	if (irq)
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  810  		rcu_dynticks_task_enter();
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  811  }
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  812  
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  813  /**
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  814   * rcu_nmi_exit - inform RCU of exit from NMI context
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  815   */
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  816  void rcu_nmi_exit(void)
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  817  {
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  818  	rcu_nmi_exit_common(false);
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  819  }
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  820  
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  821  /**
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  822   * rcu_irq_exit - inform RCU that current CPU is exiting irq towards idle
> 64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18  823   *
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  824   * Exit from an interrupt handler, which might possibly result in entering
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  825   * idle mode, in other words, leaving the mode in which read-side critical
> 7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  826   * sections can occur.  The caller must have disabled interrupts.
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  827   *
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  828   * This code assumes that the idle loop never does anything that might
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  829   * result in unbalanced calls to irq_enter() and irq_exit().  If your
> 58721f5da kernel/rcu/tree.c Paul E. McKenney    2017-10-03  830   * architecture's idle loop violates this assumption, RCU will give you what
> 58721f5da kernel/rcu/tree.c Paul E. McKenney    2017-10-03  831   * you deserve, good and hard.  But very infrequently and irreproducibly.
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  832   *
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  833   * Use things like work queues to work around this limitation.
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  834   *
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  835   * You have been warned.
> c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  836   *
> c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  837   * If you add or remove a call to rcu_irq_exit(), be sure to test with
> c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  838   * CONFIG_RCU_EQS_DEBUG=y.
> 64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18  839   */
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  840  void rcu_irq_exit(void)
> 64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18  841  {
> b04db8e19 kernel/rcu/tree.c Frederic Weisbecker 2017-11-06  842  	lockdep_assert_irqs_disabled();
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  843  	rcu_nmi_exit_common(true);
> 7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  844  }
> 7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  845  
> 7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  846  /*
> 7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  847   * Wrapper for rcu_irq_exit() where interrupts are enabled.
> c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  848   *
> c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  849   * If you add or remove a call to rcu_irq_exit_irqson(), be sure to test
> c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  850   * with CONFIG_RCU_EQS_DEBUG=y.
> 7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  851   */
> 7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  852  void rcu_irq_exit_irqson(void)
> 7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  853  {
> 7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  854  	unsigned long flags;
> 7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  855  
> 7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  856  	local_irq_save(flags);
> 7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  857  	rcu_irq_exit();
> 23b5c8fa0 kernel/rcutree.c  Paul E. McKenney    2010-09-07  858  	local_irq_restore(flags);
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  859  }
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  860  
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  861  /*
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  862   * Exit an RCU extended quiescent state, which can be either the
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  863   * idle loop or adaptive-tickless usermode execution.
> 51a1fd30f kernel/rcu/tree.c Paul E. McKenney    2017-10-03  864   *
> 51a1fd30f kernel/rcu/tree.c Paul E. McKenney    2017-10-03  865   * We crowbar the ->dynticks_nmi_nesting field to DYNTICK_IRQ_NONIDLE to
> 51a1fd30f kernel/rcu/tree.c Paul E. McKenney    2017-10-03  866   * allow for the possibility of usermode upcalls messing up our count of
> 51a1fd30f kernel/rcu/tree.c Paul E. McKenney    2017-10-03  867   * interrupt nesting level during the busy period that is just now starting.
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  868   */
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  869  static void rcu_eqs_exit(bool user)
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  870  {
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  871  	struct rcu_dynticks *rdtp;
> 84585aa8b kernel/rcu/tree.c Paul E. McKenney    2017-10-04  872  	long oldval;
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  873  
> b04db8e19 kernel/rcu/tree.c Frederic Weisbecker 2017-11-06  874  	lockdep_assert_irqs_disabled();
> c9d4b0af9 kernel/rcutree.c  Christoph Lameter   2013-08-31  875  	rdtp = this_cpu_ptr(&rcu_dynticks);
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  876  	oldval = rdtp->dynticks_nesting;
> 1ce46ee59 kernel/rcu/tree.c Paul E. McKenney    2015-05-05  877  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
> 51a1fd30f kernel/rcu/tree.c Paul E. McKenney    2017-10-03  878  	if (oldval) {
> 51a1fd30f kernel/rcu/tree.c Paul E. McKenney    2017-10-03  879  		rdtp->dynticks_nesting++;
> 9dd238e28 kernel/rcu/tree.c Paul E. McKenney    2017-10-05  880  		return;
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  881  	}
> 9dd238e28 kernel/rcu/tree.c Paul E. McKenney    2017-10-05  882  	rcu_dynticks_task_exit();
> 9dd238e28 kernel/rcu/tree.c Paul E. McKenney    2017-10-05  883  	rcu_dynticks_eqs_exit();
> 9dd238e28 kernel/rcu/tree.c Paul E. McKenney    2017-10-05  884  	rcu_cleanup_after_idle();
> 9dd238e28 kernel/rcu/tree.c Paul E. McKenney    2017-10-05  885  	trace_rcu_dyntick(TPS("End"), rdtp->dynticks_nesting, 1, rdtp->dynticks);
> e68bbb266 kernel/rcu/tree.c Paul E. McKenney    2017-10-05  886  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
> 2342172fd kernel/rcu/tree.c Paul E. McKenney    2017-10-05  887  	WRITE_ONCE(rdtp->dynticks_nesting, 1);
> 6136d6e48 kernel/rcu/tree.c Paul E. McKenney    2017-10-03  888  	WRITE_ONCE(rdtp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
> 3a5924052 kernel/rcu/tree.c Paul E. McKenney    2013-10-04  889  }
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  890  
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  891  /**
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  892   * rcu_idle_exit - inform RCU that current CPU is leaving idle
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  893   *
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  894   * Exit idle mode, in other words, -enter- the mode in which RCU
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  895   * read-side critical sections can occur.
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  896   *
> c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  897   * If you add or remove a call to rcu_idle_exit(), be sure to test with
> c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  898   * CONFIG_RCU_EQS_DEBUG=y.
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  899   */
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  900  void rcu_idle_exit(void)
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  901  {
> c5d900bf6 kernel/rcutree.c  Frederic Weisbecker 2012-07-11  902  	unsigned long flags;
> c5d900bf6 kernel/rcutree.c  Frederic Weisbecker 2012-07-11  903  
> c5d900bf6 kernel/rcutree.c  Frederic Weisbecker 2012-07-11  904  	local_irq_save(flags);
> cb349ca95 kernel/rcutree.c  Paul E. McKenney    2012-09-04  905  	rcu_eqs_exit(false);
> c5d900bf6 kernel/rcutree.c  Frederic Weisbecker 2012-07-11  906  	local_irq_restore(flags);
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  907  }
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  908  
> d1ec4c34c kernel/rcu/tree.c Paul E. McKenney    2015-05-13  909  #ifdef CONFIG_NO_HZ_FULL
> 9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  910  /**
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  911   * rcu_user_exit - inform RCU that we are exiting userspace.
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  912   *
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  913   * Exit RCU idle mode while entering the kernel because it can
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  914   * run a RCU read side critical section anytime.
> c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  915   *
> c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  916   * If you add or remove a call to rcu_user_exit(), be sure to test with
> c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  917   * CONFIG_RCU_EQS_DEBUG=y.
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  918   */
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  919  void rcu_user_exit(void)
> adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  920  {
> 91d1aa43d kernel/rcutree.c  Frederic Weisbecker 2012-11-27  921  	rcu_eqs_exit(1);
> c5d900bf6 kernel/rcutree.c  Frederic Weisbecker 2012-07-11  922  }
> d1ec4c34c kernel/rcu/tree.c Paul E. McKenney    2015-05-13  923  #endif /* CONFIG_NO_HZ_FULL */
> 19dd1591f kernel/rcutree.c  Frederic Weisbecker 2012-06-04  924  
> 19dd1591f kernel/rcutree.c  Frederic Weisbecker 2012-06-04  925  /**
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  926   * rcu_nmi_enter_common - inform RCU of entry to NMI context
> 64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18  927   *
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  928   * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  929   * rdtp->dynticks_nmi_nesting to let the RCU grace-period handling know
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  930   * that the CPU is active.  This implementation permits nested NMIs, as
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  931   * long as the nesting level does not overflow an int.  (You will probably
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  932   * run out of stack space first.)
> c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  933   *
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  934   * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
> c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  935   * with CONFIG_RCU_EQS_DEBUG=y.
> 64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18  936   */
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  937  static __always_inline void rcu_nmi_enter_common(bool irq)
> 64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18 @938  {
> c9d4b0af9 kernel/rcutree.c  Christoph Lameter   2013-08-31  939  	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> 84585aa8b kernel/rcu/tree.c Paul E. McKenney    2017-10-04  940  	long incby = 2;
> 64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18  941  
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  942  	/* Complain about underflow. */
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  943  	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting < 0);
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  944  
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  945  	/*
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  946  	 * If idle from RCU viewpoint, atomically increment ->dynticks
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  947  	 * to mark non-idle and increment ->dynticks_nmi_nesting by one.
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  948  	 * Otherwise, increment ->dynticks_nmi_nesting by two.  This means
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  949  	 * if ->dynticks_nmi_nesting is equal to one, we are guaranteed
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  950  	 * to be in the outermost NMI handler that interrupted an RCU-idle
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  951  	 * period (observation due to Andy Lutomirski).
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  952  	 */
> 02a5c550b kernel/rcu/tree.c Paul E. McKenney    2016-11-02  953  	if (rcu_dynticks_curr_cpu_in_eqs()) {
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  954  
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  955  		if (irq)
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  956  			rcu_dynticks_task_exit();
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  957  
> 2625d469b kernel/rcu/tree.c Paul E. McKenney    2016-11-02  958  		rcu_dynticks_eqs_exit();
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  959  
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  960  		if (irq)
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  961  			rcu_cleanup_after_idle();
> 1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  962  
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  963  		incby = 1;
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  964  	}
> bd2b879a1 kernel/rcu/tree.c Paul E. McKenney    2017-10-04  965  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
> bd2b879a1 kernel/rcu/tree.c Paul E. McKenney    2017-10-04  966  			  rdtp->dynticks_nmi_nesting,
> dec98900e kernel/rcu/tree.c Paul E. McKenney    2017-10-04  967  			  rdtp->dynticks_nmi_nesting + incby, rdtp->dynticks);
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  968  	WRITE_ONCE(rdtp->dynticks_nmi_nesting, /* Prevent store tearing. */
> fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  969  		   rdtp->dynticks_nmi_nesting + incby);
> 734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  970  	barrier();
> 64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18  971  }
> 64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18  972  
> 
> :::::: The code at line 778 was first introduced by commit
> :::::: fd581a91ac16187625ec509414d08d37827472c4 rcu: Move rcu_nmi_{enter,exit}() to prepare for consolidation
> 
> :::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> :::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


