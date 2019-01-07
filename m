Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1FFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB58206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HTaxOiBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfAGTAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:00:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50268 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfAGTAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:00:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x07Ii5RY139602;
        Mon, 7 Jan 2019 18:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=aOMFEBVNGOvW1I0wSNrrfo3qWHW8nPodNwQKGloyOP0=;
 b=HTaxOiBIBLU3gd035gUI8AfIvP+5buVoX8DV1jg1uZc3rC2xv2L3Ez+HX058+6iNIts4
 /SfMBTScr+vYgbc/GRhBsEgagJ1bus2VC9zZxSg+gY+rzcvRPkHLl4hLFeao9cBcqgTn
 VB//dNn0QGWO0f9uuOPBJZ5BdEeVbt/0olrzKbHmtS/RoFokL4mhE04RYY90SMeP8AUQ
 YKxMRrsSBO95wyGS4IjmDIitZGjdmFLwBXleB93Kwig6XEBzGCuAuQiI6w+mkjLKDXm3
 na7xtMIYtTNK8PDrb4zEG+NijMjzDZekdDQt/xWPCwaCbrBZmdmw4C6j5092NBVf8wCU bg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2ptm0tyj88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jan 2019 18:59:38 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x07IxbPf012887
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Jan 2019 18:59:37 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x07IxaAU007968;
        Mon, 7 Jan 2019 18:59:36 GMT
Received: from kadam (/10.175.22.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jan 2019 10:59:35 -0800
Date:   Mon, 7 Jan 2019 21:58:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     kbuild-all@01.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/5] PM / hibernate: Generate and verify signature for
 snapshot image
Message-ID: <20190107185824.GD3253@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103143227.9138-3-jlee@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9129 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901070159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Yi,

url:    https://github.com/0day-ci/linux/commits/Lee-Chun-Yi/Encryption-and-authentication-for-hibernate-snapshot-image/20190104-062004

smatch warnings:
kernel/power/user.c:411 snapshot_ioctl() warn: inconsistent returns 'mutex:&system_transition_mutex'.
  Locked on:   line 265
  Unlocked on: line 213

[ There are some returns missing.  I don't know how/why...  -dan ]

# https://github.com/0day-ci/linux/commit/1e583ff7a095d508d78bea4d35a916594c2fc23c
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 1e583ff7a095d508d78bea4d35a916594c2fc23c
vim +411 kernel/power/user.c

6e1819d61 Rafael J. Wysocki 2006-03-23  203  
52d11025d Alan Cox          2008-06-11  204  static long snapshot_ioctl(struct file *filp, unsigned int cmd,
52d11025d Alan Cox          2008-06-11  205  							unsigned long arg)
6e1819d61 Rafael J. Wysocki 2006-03-23  206  {
6e1819d61 Rafael J. Wysocki 2006-03-23  207  	int error = 0;
6e1819d61 Rafael J. Wysocki 2006-03-23  208  	struct snapshot_data *data;
af508b34d Rafael J. Wysocki 2007-10-26  209  	loff_t size;
3aef83e0e Rafael J. Wysocki 2006-12-06  210  	sector_t offset;
6e1819d61 Rafael J. Wysocki 2006-03-23  211  
6e1819d61 Rafael J. Wysocki 2006-03-23  212  	if (_IOC_TYPE(cmd) != SNAPSHOT_IOC_MAGIC)
6e1819d61 Rafael J. Wysocki 2006-03-23  213  		return -ENOTTY;
6e1819d61 Rafael J. Wysocki 2006-03-23  214  	if (_IOC_NR(cmd) > SNAPSHOT_IOC_MAXNR)
6e1819d61 Rafael J. Wysocki 2006-03-23  215  		return -ENOTTY;
6e1819d61 Rafael J. Wysocki 2006-03-23  216  	if (!capable(CAP_SYS_ADMIN))
6e1819d61 Rafael J. Wysocki 2006-03-23  217  		return -EPERM;
6e1819d61 Rafael J. Wysocki 2006-03-23  218  
55f2503c3 Pingfan Liu       2018-07-31  219  	if (!mutex_trylock(&system_transition_mutex))
25f2f3daa Rafael J. Wysocki 2008-06-11  220  		return -EBUSY;
6e1819d61 Rafael J. Wysocki 2006-03-23  221  
942f40155 Rafael J. Wysocki 2013-08-30  222  	lock_device_hotplug();
25f2f3daa Rafael J. Wysocki 2008-06-11  223  	data = filp->private_data;
52d11025d Alan Cox          2008-06-11  224  
6e1819d61 Rafael J. Wysocki 2006-03-23  225  	switch (cmd) {
6e1819d61 Rafael J. Wysocki 2006-03-23  226  
6e1819d61 Rafael J. Wysocki 2006-03-23  227  	case SNAPSHOT_FREEZE:
6e1819d61 Rafael J. Wysocki 2006-03-23  228  		if (data->frozen)
6e1819d61 Rafael J. Wysocki 2006-03-23  229  			break;
1bfcf1304 Rafael J. Wysocki 2008-10-15  230  
232b14328 Rafael J. Wysocki 2007-10-18  231  		printk("Syncing filesystems ... ");
70f68ee81 Dominik Brodowski 2018-03-14  232  		ksys_sync();
232b14328 Rafael J. Wysocki 2007-10-18  233  		printk("done.\n");
232b14328 Rafael J. Wysocki 2007-10-18  234  
1bfcf1304 Rafael J. Wysocki 2008-10-15  235  		error = freeze_processes();
8fd37a4c9 Rafael J. Wysocki 2013-08-30  236  		if (error)
8fd37a4c9 Rafael J. Wysocki 2013-08-30  237  			break;
8fd37a4c9 Rafael J. Wysocki 2013-08-30  238  
8fd37a4c9 Rafael J. Wysocki 2013-08-30  239  		error = create_basic_memory_bitmaps();
8fd37a4c9 Rafael J. Wysocki 2013-08-30  240  		if (error)
8fd37a4c9 Rafael J. Wysocki 2013-08-30  241  			thaw_processes();
8fd37a4c9 Rafael J. Wysocki 2013-08-30  242  		else
7bc9b1cff Rafael J. Wysocki 2013-10-18  243  			data->frozen = true;
8fd37a4c9 Rafael J. Wysocki 2013-08-30  244  
6e1819d61 Rafael J. Wysocki 2006-03-23  245  		break;
6e1819d61 Rafael J. Wysocki 2006-03-23  246  
6e1819d61 Rafael J. Wysocki 2006-03-23  247  	case SNAPSHOT_UNFREEZE:
2f41dddbb Rafael J. Wysocki 2007-06-16  248  		if (!data->frozen || data->ready)
6e1819d61 Rafael J. Wysocki 2006-03-23  249  			break;
c9e664f1f Rafael J. Wysocki 2010-12-03  250  		pm_restore_gfp_mask();
1e583ff7a Lee, Chun-Yi      2019-01-03  251  		snapshot_restore_trampoline();
8fd37a4c9 Rafael J. Wysocki 2013-08-30  252  		free_basic_memory_bitmaps();
aab172891 Rafael J. Wysocki 2013-09-30  253  		data->free_bitmaps = false;
6e1819d61 Rafael J. Wysocki 2006-03-23  254  		thaw_processes();
7bc9b1cff Rafael J. Wysocki 2013-10-18  255  		data->frozen = false;
6e1819d61 Rafael J. Wysocki 2006-03-23  256  		break;
6e1819d61 Rafael J. Wysocki 2006-03-23  257  
b694e52eb Jiri Slaby        2010-01-27  258  	case SNAPSHOT_CREATE_IMAGE:
6e1819d61 Rafael J. Wysocki 2006-03-23  259  		if (data->mode != O_RDONLY || !data->frozen  || data->ready) {
6e1819d61 Rafael J. Wysocki 2006-03-23  260  			error = -EPERM;
6e1819d61 Rafael J. Wysocki 2006-03-23  261  			break;
6e1819d61 Rafael J. Wysocki 2006-03-23  262  		}
1e583ff7a Lee, Chun-Yi      2019-01-03  263  		error = snapshot_key_init();
1e583ff7a Lee, Chun-Yi      2019-01-03  264  		if (error)
1e583ff7a Lee, Chun-Yi      2019-01-03  265  			return error;
                                                                ^^^^^^^^^^^^^

1e583ff7a Lee, Chun-Yi      2019-01-03  266  		error = snapshot_create_trampoline();
1e583ff7a Lee, Chun-Yi      2019-01-03  267  		if (error)
1e583ff7a Lee, Chun-Yi      2019-01-03  268  			return error;
                                                                ^^^^^^^^^^^^^
These should be break statements.

c9e664f1f Rafael J. Wysocki 2010-12-03  269  		pm_restore_gfp_mask();
eb57c1cf0 Rafael J. Wysocki 2007-10-26  270  		error = hibernation_snapshot(data->platform_support);
51d6ff7ac Srivatsa S. Bhat  2012-02-04  271  		if (!error) {
cc5d207c8 Rafael J. Wysocki 2007-10-26  272  			error = put_user(in_suspend, (int __user *)arg);
a556d5b58 Srivatsa S. Bhat  2012-02-04  273  			data->ready = !freezer_test_done && !error;
97819a262 Srivatsa S. Bhat  2011-12-01  274  			freezer_test_done = false;
97819a262 Srivatsa S. Bhat  2011-12-01  275  		}
6e1819d61 Rafael J. Wysocki 2006-03-23  276  		break;
6e1819d61 Rafael J. Wysocki 2006-03-23  277  
6e1819d61 Rafael J. Wysocki 2006-03-23  278  	case SNAPSHOT_ATOMIC_RESTORE:
8357376d3 Rafael J. Wysocki 2006-12-06  279  		snapshot_write_finalize(&data->handle);
6e1819d61 Rafael J. Wysocki 2006-03-23  280  		if (data->mode != O_WRONLY || !data->frozen ||
6e1819d61 Rafael J. Wysocki 2006-03-23  281  		    !snapshot_image_loaded(&data->handle)) {
6e1819d61 Rafael J. Wysocki 2006-03-23  282  			error = -EPERM;
6e1819d61 Rafael J. Wysocki 2006-03-23  283  			break;
6e1819d61 Rafael J. Wysocki 2006-03-23  284  		}
1e583ff7a Lee, Chun-Yi      2019-01-03  285  		if (snapshot_image_verify_decrypt()) {
1e583ff7a Lee, Chun-Yi      2019-01-03  286  			error = -EPERM;
1e583ff7a Lee, Chun-Yi      2019-01-03  287  			break;
1e583ff7a Lee, Chun-Yi      2019-01-03  288  		}
1e583ff7a Lee, Chun-Yi      2019-01-03  289  		snapshot_init_trampoline();
eb57c1cf0 Rafael J. Wysocki 2007-10-26  290  		error = hibernation_restore(data->platform_support);
6e1819d61 Rafael J. Wysocki 2006-03-23  291  		break;
6e1819d61 Rafael J. Wysocki 2006-03-23  292  
6e1819d61 Rafael J. Wysocki 2006-03-23  293  	case SNAPSHOT_FREE:
6e1819d61 Rafael J. Wysocki 2006-03-23  294  		swsusp_free();
6e1819d61 Rafael J. Wysocki 2006-03-23  295  		memset(&data->handle, 0, sizeof(struct snapshot_handle));
7bc9b1cff Rafael J. Wysocki 2013-10-18  296  		data->ready = false;
181e9bdef Rafael J. Wysocki 2012-01-29  297  		/*
181e9bdef Rafael J. Wysocki 2012-01-29  298  		 * It is necessary to thaw kernel threads here, because
181e9bdef Rafael J. Wysocki 2012-01-29  299  		 * SNAPSHOT_CREATE_IMAGE may be invoked directly after
181e9bdef Rafael J. Wysocki 2012-01-29  300  		 * SNAPSHOT_FREE.  In that case, if kernel threads were not
181e9bdef Rafael J. Wysocki 2012-01-29  301  		 * thawed, the preallocation of memory carried out by
181e9bdef Rafael J. Wysocki 2012-01-29  302  		 * hibernation_snapshot() might run into problems (i.e. it
181e9bdef Rafael J. Wysocki 2012-01-29  303  		 * might fail or even deadlock).
181e9bdef Rafael J. Wysocki 2012-01-29  304  		 */
181e9bdef Rafael J. Wysocki 2012-01-29  305  		thaw_kernel_threads();
6e1819d61 Rafael J. Wysocki 2006-03-23  306  		break;
6e1819d61 Rafael J. Wysocki 2006-03-23  307  
b694e52eb Jiri Slaby        2010-01-27  308  	case SNAPSHOT_PREF_IMAGE_SIZE:
6e1819d61 Rafael J. Wysocki 2006-03-23  309  		image_size = arg;
6e1819d61 Rafael J. Wysocki 2006-03-23  310  		break;
6e1819d61 Rafael J. Wysocki 2006-03-23  311  
af508b34d Rafael J. Wysocki 2007-10-26  312  	case SNAPSHOT_GET_IMAGE_SIZE:
af508b34d Rafael J. Wysocki 2007-10-26  313  		if (!data->ready) {
af508b34d Rafael J. Wysocki 2007-10-26  314  			error = -ENODATA;
af508b34d Rafael J. Wysocki 2007-10-26  315  			break;
af508b34d Rafael J. Wysocki 2007-10-26  316  		}
af508b34d Rafael J. Wysocki 2007-10-26  317  		size = snapshot_get_image_size();
af508b34d Rafael J. Wysocki 2007-10-26  318  		size <<= PAGE_SHIFT;
af508b34d Rafael J. Wysocki 2007-10-26  319  		error = put_user(size, (loff_t __user *)arg);
af508b34d Rafael J. Wysocki 2007-10-26  320  		break;
af508b34d Rafael J. Wysocki 2007-10-26  321  
b694e52eb Jiri Slaby        2010-01-27  322  	case SNAPSHOT_AVAIL_SWAP_SIZE:
af508b34d Rafael J. Wysocki 2007-10-26  323  		size = count_swap_pages(data->swap, 1);
af508b34d Rafael J. Wysocki 2007-10-26  324  		size <<= PAGE_SHIFT;
af508b34d Rafael J. Wysocki 2007-10-26  325  		error = put_user(size, (loff_t __user *)arg);
6e1819d61 Rafael J. Wysocki 2006-03-23  326  		break;
6e1819d61 Rafael J. Wysocki 2006-03-23  327  
b694e52eb Jiri Slaby        2010-01-27  328  	case SNAPSHOT_ALLOC_SWAP_PAGE:
6e1819d61 Rafael J. Wysocki 2006-03-23  329  		if (data->swap < 0 || data->swap >= MAX_SWAPFILES) {
6e1819d61 Rafael J. Wysocki 2006-03-23  330  			error = -ENODEV;
6e1819d61 Rafael J. Wysocki 2006-03-23  331  			break;
6e1819d61 Rafael J. Wysocki 2006-03-23  332  		}
d1d241cc2 Rafael J. Wysocki 2007-05-06  333  		offset = alloc_swapdev_block(data->swap);
6e1819d61 Rafael J. Wysocki 2006-03-23  334  		if (offset) {
6e1819d61 Rafael J. Wysocki 2006-03-23  335  			offset <<= PAGE_SHIFT;
cc5d207c8 Rafael J. Wysocki 2007-10-26  336  			error = put_user(offset, (loff_t __user *)arg);
6e1819d61 Rafael J. Wysocki 2006-03-23  337  		} else {
6e1819d61 Rafael J. Wysocki 2006-03-23  338  			error = -ENOSPC;
6e1819d61 Rafael J. Wysocki 2006-03-23  339  		}
6e1819d61 Rafael J. Wysocki 2006-03-23  340  		break;
6e1819d61 Rafael J. Wysocki 2006-03-23  341  
6e1819d61 Rafael J. Wysocki 2006-03-23  342  	case SNAPSHOT_FREE_SWAP_PAGES:
6e1819d61 Rafael J. Wysocki 2006-03-23  343  		if (data->swap < 0 || data->swap >= MAX_SWAPFILES) {
6e1819d61 Rafael J. Wysocki 2006-03-23  344  			error = -ENODEV;
6e1819d61 Rafael J. Wysocki 2006-03-23  345  			break;
6e1819d61 Rafael J. Wysocki 2006-03-23  346  		}
d1d241cc2 Rafael J. Wysocki 2007-05-06  347  		free_all_swap_pages(data->swap);
6e1819d61 Rafael J. Wysocki 2006-03-23  348  		break;
6e1819d61 Rafael J. Wysocki 2006-03-23  349  
9b238205b Luca Tettamanti   2006-03-23  350  	case SNAPSHOT_S2RAM:
9b238205b Luca Tettamanti   2006-03-23  351  		if (!data->frozen) {
9b238205b Luca Tettamanti   2006-03-23  352  			error = -EPERM;
9b238205b Luca Tettamanti   2006-03-23  353  			break;
9b238205b Luca Tettamanti   2006-03-23  354  		}
6c961dfb7 Rafael J. Wysocki 2007-07-19  355  		/*
6c961dfb7 Rafael J. Wysocki 2007-07-19  356  		 * Tasks are frozen and the notifiers have been called with
6c961dfb7 Rafael J. Wysocki 2007-07-19  357  		 * PM_HIBERNATION_PREPARE
6c961dfb7 Rafael J. Wysocki 2007-07-19  358  		 */
6c961dfb7 Rafael J. Wysocki 2007-07-19  359  		error = suspend_devices_and_enter(PM_SUSPEND_MEM);
7bc9b1cff Rafael J. Wysocki 2013-10-18  360  		data->ready = false;
9b238205b Luca Tettamanti   2006-03-23  361  		break;
9b238205b Luca Tettamanti   2006-03-23  362  
eb57c1cf0 Rafael J. Wysocki 2007-10-26  363  	case SNAPSHOT_PLATFORM_SUPPORT:
eb57c1cf0 Rafael J. Wysocki 2007-10-26  364  		data->platform_support = !!arg;
eb57c1cf0 Rafael J. Wysocki 2007-10-26  365  		break;
eb57c1cf0 Rafael J. Wysocki 2007-10-26  366  
eb57c1cf0 Rafael J. Wysocki 2007-10-26  367  	case SNAPSHOT_POWER_OFF:
eb57c1cf0 Rafael J. Wysocki 2007-10-26  368  		if (data->platform_support)
eb57c1cf0 Rafael J. Wysocki 2007-10-26  369  			error = hibernation_platform_enter();
eb57c1cf0 Rafael J. Wysocki 2007-10-26  370  		break;
eb57c1cf0 Rafael J. Wysocki 2007-10-26  371  
37b2ba12d Rafael J. Wysocki 2006-12-06  372  	case SNAPSHOT_SET_SWAP_AREA:
d1d241cc2 Rafael J. Wysocki 2007-05-06  373  		if (swsusp_swap_in_use()) {
37b2ba12d Rafael J. Wysocki 2006-12-06  374  			error = -EPERM;
37b2ba12d Rafael J. Wysocki 2006-12-06  375  		} else {
37b2ba12d Rafael J. Wysocki 2006-12-06  376  			struct resume_swap_area swap_area;
37b2ba12d Rafael J. Wysocki 2006-12-06  377  			dev_t swdev;
37b2ba12d Rafael J. Wysocki 2006-12-06  378  
37b2ba12d Rafael J. Wysocki 2006-12-06  379  			error = copy_from_user(&swap_area, (void __user *)arg,
37b2ba12d Rafael J. Wysocki 2006-12-06  380  					sizeof(struct resume_swap_area));
37b2ba12d Rafael J. Wysocki 2006-12-06  381  			if (error) {
37b2ba12d Rafael J. Wysocki 2006-12-06  382  				error = -EFAULT;
37b2ba12d Rafael J. Wysocki 2006-12-06  383  				break;
37b2ba12d Rafael J. Wysocki 2006-12-06  384  			}
37b2ba12d Rafael J. Wysocki 2006-12-06  385  
37b2ba12d Rafael J. Wysocki 2006-12-06  386  			/*
37b2ba12d Rafael J. Wysocki 2006-12-06  387  			 * User space encodes device types as two-byte values,
37b2ba12d Rafael J. Wysocki 2006-12-06  388  			 * so we need to recode them
37b2ba12d Rafael J. Wysocki 2006-12-06  389  			 */
d88d4050d Jiri Slaby        2010-04-10  390  			swdev = new_decode_dev(swap_area.dev);
37b2ba12d Rafael J. Wysocki 2006-12-06  391  			if (swdev) {
37b2ba12d Rafael J. Wysocki 2006-12-06  392  				offset = swap_area.offset;
7bf236874 Rafael J. Wysocki 2007-01-05  393  				data->swap = swap_type_of(swdev, offset, NULL);
37b2ba12d Rafael J. Wysocki 2006-12-06  394  				if (data->swap < 0)
37b2ba12d Rafael J. Wysocki 2006-12-06  395  					error = -ENODEV;
37b2ba12d Rafael J. Wysocki 2006-12-06  396  			} else {
37b2ba12d Rafael J. Wysocki 2006-12-06  397  				data->swap = -1;
37b2ba12d Rafael J. Wysocki 2006-12-06  398  				error = -EINVAL;
37b2ba12d Rafael J. Wysocki 2006-12-06  399  			}
37b2ba12d Rafael J. Wysocki 2006-12-06  400  		}
37b2ba12d Rafael J. Wysocki 2006-12-06  401  		break;
37b2ba12d Rafael J. Wysocki 2006-12-06  402  
6e1819d61 Rafael J. Wysocki 2006-03-23  403  	default:
6e1819d61 Rafael J. Wysocki 2006-03-23  404  		error = -ENOTTY;
6e1819d61 Rafael J. Wysocki 2006-03-23  405  
6e1819d61 Rafael J. Wysocki 2006-03-23  406  	}
25f2f3daa Rafael J. Wysocki 2008-06-11  407  
942f40155 Rafael J. Wysocki 2013-08-30  408  	unlock_device_hotplug();
55f2503c3 Pingfan Liu       2018-07-31  409  	mutex_unlock(&system_transition_mutex);
25f2f3daa Rafael J. Wysocki 2008-06-11  410  
6e1819d61 Rafael J. Wysocki 2006-03-23 @411  	return error;
6e1819d61 Rafael J. Wysocki 2006-03-23  412  }
6e1819d61 Rafael J. Wysocki 2006-03-23  413  

:::::: The code at line 411 was first introduced by commit
:::::: 6e1819d615f24ce0726a7d0bd3dd0152d7b21654 [PATCH] swsusp: userland interface

:::::: TO: Rafael J. Wysocki <rjw@sisk.pl>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
