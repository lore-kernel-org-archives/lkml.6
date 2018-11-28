Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A462C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD1C2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5Y151if/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD1C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeK1U3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:29:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37172 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbeK1U3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:29:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAS9Nikn082031;
        Wed, 28 Nov 2018 09:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=PpdAxCapdIjxZpv4gdPt8uyYNjUd0cO+LG+ozgvVL6U=;
 b=5Y151if/p+eBRgKMyF/6VmCqK5SuiOHbjid9l7vrbxYcJut/Q7HvvszmnYdqbD4hvjrf
 CUoAS6t8va+2QZhlFIxxTJ7X5uB2FjxbqNV9dNGJ63CuAE5z5TWvLIqmSIrDEqRe4KhE
 xcwOuuylTHStqTXKIm2D83QOhPRk6uPmq3F1cD8IJ3WR9jB14z+KNFD6I6PdrwDPdxXi
 XqM6fsr27QjPZHII/JjEjO04kwalGtUauSyyJVIx4lc/uxCXx3f+WHvl3mICmu7kTGos
 RcqYPMwfh14xIf9wug/5BnaqourdDlwCtSx4lmcfepbLm4WsJIvgwFUarlbcAO8c26Wg Ig== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nxx2u917m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 09:28:31 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAS9SU4G024717
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 09:28:30 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAS9SUVj002494;
        Wed, 28 Nov 2018 09:28:30 GMT
Received: from unbuntlaptop (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Nov 2018 01:28:29 -0800
Date:   Wed, 28 Nov 2018 12:28:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Davide Caratti <dcaratti@redhat.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>
Subject: net/sched/act_police.c:232 tcf_police_init() warn: possible memory
 leak of 'new'
Message-ID: <20181128092822.GK3073@unbuntlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ef78e5ec9214376c5cb989f5da70b02d0c117b66
commit: f2cbd485282014132851bf37cb2ca624a456275d net/sched: act_police: fix race condition on state variables

smatch warnings:
net/sched/act_police.c:232 tcf_police_init() warn: possible memory leak of 'new'

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f2cbd485282014132851bf37cb2ca624a456275d
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout f2cbd485282014132851bf37cb2ca624a456275d
vim +/new +232 net/sched/act_police.c

53b2bf3f8 net/sched/act_police.c Patrick McHardy   2008-01-23   82  
2ac063474 net/sched/act_police.c Jamal Hadi Salim  2018-08-12   83  static int tcf_police_init(struct net *net, struct nlattr *nla,
a85a970af net/sched/act_police.c WANG Cong         2016-07-25   84  			       struct nlattr *est, struct tc_action **a,
789871bb2 net/sched/act_police.c Vlad Buslov       2018-07-05   85  			       int ovr, int bind, bool rtnl_held,
589dad6d7 net/sched/act_police.c Alexander Aring   2018-02-15   86  			       struct netlink_ext_ack *extack)
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16   87  {
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16   88  	int ret = 0, err;
7ba699c60 net/sched/act_police.c Patrick McHardy   2008-01-22   89  	struct nlattr *tb[TCA_POLICE_MAX + 1];
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16   90  	struct tc_police *parm;
e9ce1cd3c net/sched/act_police.c David S. Miller   2006-08-21   91  	struct tcf_police *police;
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16   92  	struct qdisc_rate_table *R_tab = NULL, *P_tab = NULL;
ddf97ccdd net/sched/act_police.c WANG Cong         2016-02-22   93  	struct tc_action_net *tn = net_generic(net, police_net_id);
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13   94  	struct tcf_police_params *new;
0852e4552 net/sched/act_police.c WANG Cong         2016-08-13   95  	bool exists = false;
1e9b3d533 net/sched/act_police.c Patrick McHardy   2006-11-30   96  	int size;
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16   97  
cee63723b net/sched/act_police.c Patrick McHardy   2008-01-23   98  	if (nla == NULL)
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16   99  		return -EINVAL;
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  100  
fceb6435e net/sched/act_police.c Johannes Berg     2017-04-12  101  	err = nla_parse_nested(tb, TCA_POLICE_MAX, nla, police_policy, NULL);
cee63723b net/sched/act_police.c Patrick McHardy   2008-01-23  102  	if (err < 0)
cee63723b net/sched/act_police.c Patrick McHardy   2008-01-23  103  		return err;
cee63723b net/sched/act_police.c Patrick McHardy   2008-01-23  104  
7ba699c60 net/sched/act_police.c Patrick McHardy   2008-01-22  105  	if (tb[TCA_POLICE_TBF] == NULL)
1e9b3d533 net/sched/act_police.c Patrick McHardy   2006-11-30  106  		return -EINVAL;
7ba699c60 net/sched/act_police.c Patrick McHardy   2008-01-22  107  	size = nla_len(tb[TCA_POLICE_TBF]);
1e9b3d533 net/sched/act_police.c Patrick McHardy   2006-11-30  108  	if (size != sizeof(*parm) && size != sizeof(struct tc_police_compat))
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  109  		return -EINVAL;
0852e4552 net/sched/act_police.c WANG Cong         2016-08-13  110  
7ba699c60 net/sched/act_police.c Patrick McHardy   2008-01-22  111  	parm = nla_data(tb[TCA_POLICE_TBF]);
0190c1d45 net/sched/act_police.c Vlad Buslov       2018-07-05  112  	err = tcf_idr_check_alloc(tn, &parm->index, a, bind);
0190c1d45 net/sched/act_police.c Vlad Buslov       2018-07-05  113  	if (err < 0)
0190c1d45 net/sched/act_police.c Vlad Buslov       2018-07-05  114  		return err;
0190c1d45 net/sched/act_police.c Vlad Buslov       2018-07-05  115  	exists = err;
0852e4552 net/sched/act_police.c WANG Cong         2016-08-13  116  	if (exists && bind)
0852e4552 net/sched/act_police.c WANG Cong         2016-08-13  117  		return 0;
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  118  
0852e4552 net/sched/act_police.c WANG Cong         2016-08-13  119  	if (!exists) {
65a206c01 net/sched/act_police.c Chris Mi          2017-08-30  120  		ret = tcf_idr_create(tn, parm->index, NULL, a,
93be42f91 net/sched/act_police.c Davide Caratti    2018-09-13  121  				     &act_police_ops, bind, true);
0190c1d45 net/sched/act_police.c Vlad Buslov       2018-07-05  122  		if (ret) {
0190c1d45 net/sched/act_police.c Vlad Buslov       2018-07-05  123  			tcf_idr_cleanup(tn, parm->index);
a03e6fe56 net/sched/act_police.c WANG Cong         2016-06-06  124  			return ret;
0190c1d45 net/sched/act_police.c Vlad Buslov       2018-07-05  125  		}
a03e6fe56 net/sched/act_police.c WANG Cong         2016-06-06  126  		ret = ACT_P_CREATED;
4e8ddd7f1 net/sched/act_police.c Vlad Buslov       2018-07-05  127  	} else if (!ovr) {
65a206c01 net/sched/act_police.c Chris Mi          2017-08-30  128  		tcf_idr_release(*a, bind);
0852e4552 net/sched/act_police.c WANG Cong         2016-08-13  129  		return -EEXIST;
e9ce1cd3c net/sched/act_police.c David S. Miller   2006-08-21  130  	}
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  131  
a85a970af net/sched/act_police.c WANG Cong         2016-07-25  132  	police = to_police(*a);
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  133  	if (parm->rate.rate) {
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  134  		err = -ENOMEM;
e9bc3fa28 net/sched/act_police.c Alexander Aring   2017-12-20  135  		R_tab = qdisc_get_rtab(&parm->rate, tb[TCA_POLICE_RATE], NULL);
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  136  		if (R_tab == NULL)
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  137  			goto failure;
c1b56878f net/sched/act_police.c Stephen Hemminger 2008-11-25  138  
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  139  		if (parm->peakrate.rate) {
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  140  			P_tab = qdisc_get_rtab(&parm->peakrate,
e9bc3fa28 net/sched/act_police.c Alexander Aring   2017-12-20  141  					       tb[TCA_POLICE_PEAKRATE], NULL);
71bcb09a5 net/sched/act_police.c Stephen Hemminger 2008-11-25  142  			if (P_tab == NULL)
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  143  				goto failure;
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  144  		}
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  145  	}
71bcb09a5 net/sched/act_police.c Stephen Hemminger 2008-11-25  146  
71bcb09a5 net/sched/act_police.c Stephen Hemminger 2008-11-25  147  	if (est) {
93be42f91 net/sched/act_police.c Davide Caratti    2018-09-13  148  		err = gen_replace_estimator(&police->tcf_bstats,
93be42f91 net/sched/act_police.c Davide Caratti    2018-09-13  149  					    police->common.cpu_bstats,
71bcb09a5 net/sched/act_police.c Stephen Hemminger 2008-11-25  150  					    &police->tcf_rate_est,
edb09eb17 net/sched/act_police.c Eric Dumazet      2016-06-06  151  					    &police->tcf_lock,
edb09eb17 net/sched/act_police.c Eric Dumazet      2016-06-06  152  					    NULL, est);
71bcb09a5 net/sched/act_police.c Stephen Hemminger 2008-11-25  153  		if (err)
74030603d net/sched/act_police.c WANG Cong         2017-06-13  154  			goto failure;
a883bf564 net/sched/act_police.c Jarek Poplawski   2009-03-04  155  	} else if (tb[TCA_POLICE_AVRATE] &&
a883bf564 net/sched/act_police.c Jarek Poplawski   2009-03-04  156  		   (ret == ACT_P_CREATED ||
1c0d32fde net/sched/act_police.c Eric Dumazet      2016-12-04  157  		    !gen_estimator_active(&police->tcf_rate_est))) {
a883bf564 net/sched/act_police.c Jarek Poplawski   2009-03-04  158  		err = -EINVAL;
74030603d net/sched/act_police.c WANG Cong         2017-06-13  159  		goto failure;
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  160  	}
71bcb09a5 net/sched/act_police.c Stephen Hemminger 2008-11-25  161  
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  162  	new = kzalloc(sizeof(*new), GFP_KERNEL);
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  163  	if (unlikely(!new)) {
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  164  		err = -ENOMEM;
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  165  		goto failure;
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  166  	}
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  167  
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  168  	/* No failure allowed after this point */
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  169  	new->tcfp_mtu = parm->mtu;
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  170  	if (!new->tcfp_mtu) {
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  171  		new->tcfp_mtu = ~0;
c6d14ff11 net/sched/act_police.c Jiri Pirko        2013-02-12  172  		if (R_tab)
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  173  			new->tcfp_mtu = 255 << R_tab->rate.cell_log;
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  174  	}
c6d14ff11 net/sched/act_police.c Jiri Pirko        2013-02-12  175  	if (R_tab) {
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  176  		new->rate_present = true;
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  177  		psched_ratecfg_precompute(&new->rate, &R_tab->rate, 0);
c6d14ff11 net/sched/act_police.c Jiri Pirko        2013-02-12  178  		qdisc_put_rtab(R_tab);
c6d14ff11 net/sched/act_police.c Jiri Pirko        2013-02-12  179  	} else {
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  180  		new->rate_present = false;
c6d14ff11 net/sched/act_police.c Jiri Pirko        2013-02-12  181  	}
c6d14ff11 net/sched/act_police.c Jiri Pirko        2013-02-12  182  	if (P_tab) {
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  183  		new->peak_present = true;
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  184  		psched_ratecfg_precompute(&new->peak, &P_tab->rate, 0);
c6d14ff11 net/sched/act_police.c Jiri Pirko        2013-02-12  185  		qdisc_put_rtab(P_tab);
c6d14ff11 net/sched/act_police.c Jiri Pirko        2013-02-12  186  	} else {
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  187  		new->peak_present = false;
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  188  	}
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  189  
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  190  	new->tcfp_burst = PSCHED_TICKS2NS(parm->burst);
f2cbd4852 net/sched/act_police.c Davide Caratti    2018-11-20  191  	if (new->peak_present)
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  192  		new->tcfp_mtu_ptoks = (s64)psched_l2t_ns(&new->peak,
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  193  							 new->tcfp_mtu);
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  194  
7ba699c60 net/sched/act_police.c Patrick McHardy   2008-01-22  195  	if (tb[TCA_POLICE_AVRATE])
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  196  		new->tcfp_ewma_rate = nla_get_u32(tb[TCA_POLICE_AVRATE]);
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  197  
c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  198  	if (tb[TCA_POLICE_RESULT]) {
c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  199  		new->tcfp_result = nla_get_u32(tb[TCA_POLICE_RESULT]);
c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  200  		if (TC_ACT_EXT_CMP(new->tcfp_result, TC_ACT_GOTO_CHAIN)) {
c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  201  			NL_SET_ERR_MSG(extack,
c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  202  				       "goto chain not allowed on fallback");
c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  203  			err = -EINVAL;
c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  204  			goto failure;
                                                                                        ^^^^^^^^^^^^

kfree_rcu(new, rcu); ?

c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  205  		}
c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  206  	}
c08f5ed5d net/sched/act_police.c Davide Caratti    2018-10-20  207  
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  208  	spin_lock_bh(&police->tcf_lock);
f2cbd4852 net/sched/act_police.c Davide Caratti    2018-11-20  209  	spin_lock_bh(&police->tcfp_lock);
f2cbd4852 net/sched/act_police.c Davide Caratti    2018-11-20  210  	police->tcfp_t_c = ktime_get_ns();
f2cbd4852 net/sched/act_police.c Davide Caratti    2018-11-20  211  	police->tcfp_toks = new->tcfp_burst;
f2cbd4852 net/sched/act_police.c Davide Caratti    2018-11-20  212  	if (new->peak_present)
f2cbd4852 net/sched/act_police.c Davide Caratti    2018-11-20  213  		police->tcfp_ptoks = new->tcfp_mtu_ptoks;
f2cbd4852 net/sched/act_police.c Davide Caratti    2018-11-20  214  	spin_unlock_bh(&police->tcfp_lock);
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  215  	police->tcf_action = parm->action;
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  216  	rcu_swap_protected(police->params,
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  217  			   new,
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  218  			   lockdep_is_held(&police->tcf_lock));
e9ce1cd3c net/sched/act_police.c David S. Miller   2006-08-21  219  	spin_unlock_bh(&police->tcf_lock);
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  220  
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  221  	if (new)
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  222  		kfree_rcu(new, rcu);
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  223  
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  224  	if (ret == ACT_P_CREATED)
2d550dbad net/sched/act_police.c Davide Caratti    2018-09-13  225  		tcf_idr_insert(tn, *a);
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  226  	return ret;
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  227  
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  228  failure:
71bcb09a5 net/sched/act_police.c Stephen Hemminger 2008-11-25  229  	qdisc_put_rtab(P_tab);
71bcb09a5 net/sched/act_police.c Stephen Hemminger 2008-11-25  230  	qdisc_put_rtab(R_tab);
5bf7f8185 net/sched/act_police.c Davide Caratti    2018-03-19  231  	tcf_idr_release(*a, bind);
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16 @232  	return err;
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  233  }
^1da177e4 net/sched/police.c     Linus Torvalds    2005-04-16  234  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
