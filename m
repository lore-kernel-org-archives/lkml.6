Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbeEPNwi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:52:38 -0400
Received: from mail-db5eur01on0068.outbound.protection.outlook.com ([104.47.2.68]:64698
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751595AbeEPNwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:52:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-13-git-send-email-vladbu@mellanox.com> <20180516095953.GI1972@nanopsycho> <vbf4lj724th.fsf@reg-r-vrt-018-180.mtr.labs.mlnx> <20180516122600.GM1972@nanopsycho> <vbfwow322k1.fsf@reg-r-vrt-018-180.mtr.labs.mlnx> <20180516132135.GN1972@nanopsycho>
User-agent: mu4e 0.9.16; emacs 25.3.50.2
From: Vlad Buslov <vladbu@mellanox.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 12/14] net: sched: retry action check-insert on concurrent modification
Message-ID: <vbfvabn1zic.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
In-reply-to: <20180516132135.GN1972@nanopsycho>
Date: Wed, 16 May 2018 16:52:20 +0300
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR07CA0143.eurprd07.prod.outlook.com
 (2603:10a6:802:16::30) To VI1PR05MB4702.eurprd05.prod.outlook.com
 (2603:10a6:802:60::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4702;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4702;3:eHg/1eeYg12aEh72qeHpJuQ1OGH+JJhWPXZtwT5gseJUl3qxW8MQSlyTanGg5fNwMvbV3SrTzVtfTDkGXQRZqV9BOO63oJVsIRFZSC6ezUwBbA6QaHZcdszHQfffGhz5ht7/rdBPMsrDsdLvzTU3KVuI5IVjtoZEQJ/Y4m4I5L3F4d86FykZd+5vTrQrgy6R4I77oABo+mus186zPZSczfms644+mx58yVb6yt9unuVAq0AA57q1djHiBa1K9izv;25:2YE0FxuU9ymP14em75SeO6245BPvlUMlNMtcD+uau83K/RmKd1wWzR2cqr8JVAz3yrgjMdj12Qi/DWYSZ2G4x1TOIEtDf9isQVDM//e/kQwFI/yvWo+8msM9446pG9slW8+H2uLgEmn1/XnuvZ+xrw4nn0anof5owkWgbc2CgXJOrBingw8oYH9u4y5xAwjqhcFv07ww+SCsAvDY2neN6D4XzdChkME2/hEcSoRy+FaO9szuc8I6c1SAUqsxEneISMkQcVaXiCTBaHyvqjj5xpl5zrz6xxgsUVDyqsZ1HeEAJGuVqeRn+WYOYIKFpROp45EzndF/rq5/uOqiTm27Cw==;31:Isf93WXdko53WSqbyj86TxAgow3MtKaSOHfxZcqDCPe2zWREe3oK79MWtS6UOrL6DWMhKum5yWCu3rh5sZ+E9i9cJVBGugpcesB4ohfvcNR4RdKBksezF/oZylH/HHJP9cQ34lsZbO7lllxEyRs2ADFLb3B6Uw3xrebYTWjuw70aAzcjOYgd+PKvilAV69KLMnC2m2IG1fWzWD4aKSfmT7/waaIG2o2ExAaa15tOGFQ=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4702:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4702;20:Kyo6i9fen7UPGChg1ZaHDk7b94snLxMqu8jPS8Z37vh5i9v++QgszoJdSSx9p2GY6bDfafgIZ14ysYvBGRTf49e3mCPIL72QV7eIUOZb4B8zyE/RKKJAPcvzCW3h2d1ebfxaFWY63HOXabKpSGUEC6F9n+9tdWIUuLt3iLkbCnnurg7s+QmIp83kIUfCb+L5wz7DF9RCgrEsE7LLEkB40uuq41jf4NWkg5lb6O2qBrPzMLnDyNjAzUj2zqUBd2MPDOuu31+5BOMRbri9ZUAifpuYSE8hgHx29AbUxLSJjpihpS2547JwswCAh9edjeb2uszukWr0sNHF6EQdaQaC9CXJiIwf66cb7DPfpbhuUD9WIBPDZ/H/iqtsyfov1qKpq3G5RqChisawpi6tzES1V6znQM98ciER7xviJ3kR9qHEPDkCJtCg+3amAzRX4orJz4fpHUe7lFN45PTIOBR6Ieg5+0ZkuPeKsHaiG9Hmgx6QDAn26qNMz9E+np2bVKop;4:/jft8T2APy7JUXZyu4dkLxjcQKP6FnMLzffXRSZHjrZnWkQKLDnvF+vFXpRWTlX5ZNdKWMJwNu2/zJ1llYe1YnaiyUeqyonkTrfYHjVql8UoN84joayJEVQoKYOSyomWiBdBcniQ/Eb7IHwQtqagK3nL3QWUgOR/BNW15Xv/Yw2/6SLI1e8d4TjMNwxnVo4zxS2JvXvHYQw4lVm6gW1dakZm95ZUjXMXfmw/O9s8ub79tOVK8ZJ6kvEV9xOWw3VW3zo2VdgOiKAsfTx6uhCzlqruycIQDekWak8dARfi1Ed8Ro/+ST8G9OIx+5/EtUhJ
X-Microsoft-Antispam-PRVS: <VI1PR05MB470211CC426AFFCB45249E37AD920@VI1PR05MB4702.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR05MB4702;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4702;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(39380400002)(396003)(376002)(346002)(189003)(199004)(51444003)(107886003)(26005)(446003)(6116002)(386003)(11346002)(81156014)(81166006)(39060400002)(956004)(316002)(7416002)(16586007)(50466002)(48376002)(58126008)(486006)(8676002)(478600001)(105586002)(59450400001)(25786009)(97736004)(476003)(106356001)(6512007)(9686003)(76176011)(6246003)(16526019)(53936002)(6666003)(6916009)(8936002)(5660300001)(66066001)(2906002)(229853002)(4326008)(47776003)(68736007)(52116002)(3846002)(7696005)(7736002)(305945005)(86362001)(6486002)(93886005)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4702;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4702;23:NV3uHcsSvP9l+Vb9QuUBGMFY618OiPpgAVf9uVu7j?=
 =?us-ascii?Q?fWP5jIiHxWfpR6TwuhWgl1AwD8gmmbDrTV3dhd2axD6+V/YnEQG5CpK4scjD?=
 =?us-ascii?Q?3anu2hfPBjXsI8ydZsdVsXUS/MtXSKZNT7kaY3NHN4TmLCO4UI0Cg7y3e/7u?=
 =?us-ascii?Q?1CjdSDKsKMx+Ctq1zDpJNVUXYHXHrJDDnY1s9bCyZqO/T7zcza1Zv9RiqT17?=
 =?us-ascii?Q?OJZTDpayTeDen3q1xLztMkE/mRnCuYDaffgdY8mJIxd47f8NyM2dXerYK6IW?=
 =?us-ascii?Q?//CnGgtSEHNphedP0x5F+R9I7VdkSSJioH4mXqjDF0L6lauegGZLHtAHxsq+?=
 =?us-ascii?Q?i7EeF2Fk/fKFD3rQ8eoTYXHg5wlSCfpfXcKTQ+ebd49QJLQub879CMXycbMk?=
 =?us-ascii?Q?Wyf4bVSgrv3mPlHm9M4fObRUw3lnY8U7bK+/knW0cvN9QkzjoAZsyQaa9FRj?=
 =?us-ascii?Q?OkHwoaH4kB1rNSzNgghrT99If9pgndVXwYo0lAPDYo8EfiBknDtRXTsOG5VB?=
 =?us-ascii?Q?yqfib4FRJI4PvNrBBJiD+br3+eVOG9ktuFlB7HMZiydnqz6lyZ5J7kwRTBcQ?=
 =?us-ascii?Q?DnIg6ynKCF2q/EGAutAhInUHZIB4xlpZporNmWEC3Xi1a8PmObfRgiFnMYMf?=
 =?us-ascii?Q?Asg0pLiJ5WmAb0l5cyaQBPWbltERb3jKFOk6tQ7J0IIgElEzBT1wSyqcw4Uc?=
 =?us-ascii?Q?OFZSgx38R6Dp96Nn77gHcUs5S5Gr0lEjMwSzFPrWQaia3AdIAETNCOcwx+of?=
 =?us-ascii?Q?v37T3pa383TtQMT8mbGaRTbcktOBLvrqi/FKK0KYQTwG5zTNlRZxsAc1nA1L?=
 =?us-ascii?Q?ZM2nZxU7YwHSeUUpGr2CD8jL9y+k2HaWruGTTYnZwHsd4JPpLmni3Erh72Fr?=
 =?us-ascii?Q?qT1SK9vw31rNRhhjv/AGN8NOG7O1u1g9XUPyQ7HuHccN1Q6KxlWc0V6/svEj?=
 =?us-ascii?Q?jFf++ULgpU4RKRXMQEdk1y7d4Y8CjReBoh9Gs7XZPQg4wOLPwQUSrmv0oov8?=
 =?us-ascii?Q?QAcOmhL0R8wSDxkJI9l+jdwUCxoWESggr5qbX3UApInxABlFWlDQUpZjQltZ?=
 =?us-ascii?Q?NhmJn9TKHAkY3gaGsg3GtPu/FPsXhJVUzTUXVDDFeukR4rS3R0FrcnYOKS03?=
 =?us-ascii?Q?Ubolpw+E9oQJcI6mi3jSMvhhst7uz5K40X0lFXskZ2K3yHUpjVGXmLXaFD/t?=
 =?us-ascii?Q?v3mP6Txg9z6a1kR/Azhxf64wTwxte91SpjKZXcplUWdjsSGRNB3HmMnpONf+?=
 =?us-ascii?Q?t1iQpiiXJEZNWLuoeV2I1h9DUz1ZGrFkC20cl6c8lN6Ty5dtSbptnocAl9jI?=
 =?us-ascii?Q?MeyeYU955ju4yyWevYO28Y=3D?=
X-Microsoft-Antispam-Message-Info: kMjSLk8wiAj4oKhN4nvY32xIKTwkU8sVkg7zOcmrpxK+DBcAykT2TgHFIscNWxD939Eg9QYCDXiwqT6LYIhfjZKbl3g/1RfO8MkJLlME4iTsIqBgYnEGO8hP+H9c/35Z7E5CxtsaXzvMDVt9Pf3uvP7L2Xj++m7NGZpD2d6ur/3tKQMnGtVNeik6p2w6i5ZR
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4702;6:sC53FVqyP2fmcO0DX0EWe3IYHVNrNBVfnJfFr22Qlqsq/VvyQWtJ+rLj2IW4kn47r95McAkbT6KZlH3kjy4r0iS44+6fY5bYEFvn6KMQqrmlyhPkfz0+4ms7/PpiPc6AN1Z9eP0seZNV9/Kl89KnY+RmrwifndzHWvH41FaswEJOh0fNha3HGFAvvSN0gvZvZHE7x4Oy0VKAC/Akmc8z3V90CcKxJuiz5fX9cq4Pfa6XJGo5L/xKBf0PcktTdkdorcCSrdTU3hVRFAHWiVDfJoUQCBM5Hu/FOyKD1BpcLzcx0oZt5bBOb1T2kB3r8/fMWnXzOCHEmYoY5aB56MMvwOqQ7qtnG9GMbo7AJA2sLwayqu0WJzwxwtA7JhfcXlHsX08jyPM6q625bsW+VViCufPzzE26rBuVAfWlPvIsRqObBOq/mbjQxIVfP1yGyD2JduMgh3ctn9cfW3n7IBKKjA==;5:YOsSdEXPCbKfz/594qDhYXFZp5iZ2IMcIsDcYgqiZdahFmNyX2MWwhBtak+sR2VGkEa7DIz/kjR0vjj50diZKSOa7Ig5/b501XTmUVSX/Q/kD3Kaa9f1Og3GAY/9fyg7IiSysh8oPdXjYMYLmpI7OBxtw/kTpxfg7NMXQxOuWCg=;24:273jxygYHPsYTZ6tT+73fBTLnKhSxPXna77D8GWol/98OCGZpEova187mPXZkOPV1gpBX3rym8n1nTmMpES9yCYGb+tpmpes/1WCvPbgd3c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4702;7:7AM+WIR+7emX9JrFvS0vqFRb9YvUl9kIsFVrJWZgTjb7bKC9jPXaQwYGi9+LIpVj/aHRnlnxYPOjtP/ze8C2ISFVGgjtA/Et9Co6Wp7Q5FxkN6OMfYGCuRrNbmUrjhajGa5omTfe+p90H1OxYr9fyrdCVQBzefHxXrPk5KqWMckFL1L6PmESvvVuF5D/wbWfB/XlDOTQd7rnq+97i4/G6P4QcNWCmbJmTxPhylHHKKSXpNWE21ot/o8o9J5EyVTJ
X-MS-Office365-Filtering-Correlation-Id: 3af50948-6461-4acb-581e-08d5bb3442e8
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 13:52:25.7072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af50948-6461-4acb-581e-08d5bb3442e8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4702
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 16 May 2018 at 13:21, Jiri Pirko <jiri@resnulli.us> wrote:
> Wed, May 16, 2018 at 02:43:58PM CEST, vladbu@mellanox.com wrote:
>>
>>On Wed 16 May 2018 at 12:26, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Wed, May 16, 2018 at 01:55:06PM CEST, vladbu@mellanox.com wrote:
>>>>
>>>>On Wed 16 May 2018 at 09:59, Jiri Pirko <jiri@resnulli.us> wrote:
>>>>> Mon, May 14, 2018 at 04:27:13PM CEST, vladbu@mellanox.com wrote:
>>>>>>Retry check-insert sequence in action init functions if action with same
>>>>>>index was inserted concurrently.
>>>>>>
>>>>>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>>>>>---
>>>>>> net/sched/act_bpf.c        | 8 +++++++-
>>>>>> net/sched/act_connmark.c   | 8 +++++++-
>>>>>> net/sched/act_csum.c       | 8 +++++++-
>>>>>> net/sched/act_gact.c       | 8 +++++++-
>>>>>> net/sched/act_ife.c        | 8 +++++++-
>>>>>> net/sched/act_ipt.c        | 8 +++++++-
>>>>>> net/sched/act_mirred.c     | 8 +++++++-
>>>>>> net/sched/act_nat.c        | 8 +++++++-
>>>>>> net/sched/act_pedit.c      | 8 +++++++-
>>>>>> net/sched/act_police.c     | 9 ++++++++-
>>>>>> net/sched/act_sample.c     | 8 +++++++-
>>>>>> net/sched/act_simple.c     | 9 ++++++++-
>>>>>> net/sched/act_skbedit.c    | 8 +++++++-
>>>>>> net/sched/act_skbmod.c     | 8 +++++++-
>>>>>> net/sched/act_tunnel_key.c | 9 ++++++++-
>>>>>> net/sched/act_vlan.c       | 9 ++++++++-
>>>>>> 16 files changed, 116 insertions(+), 16 deletions(-)
>>>>>>
>>>>>>diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
>>>>>>index 5554bf7..7e20fdc 100644
>>>>>>--- a/net/sched/act_bpf.c
>>>>>>+++ b/net/sched/act_bpf.c
>>>>>>@@ -299,10 +299,16 @@ static int tcf_bpf_init(struct net *net, struct nlattr *nla,
>>>>>> 
>>>>>> 	parm = nla_data(tb[TCA_ACT_BPF_PARMS]);
>>>>>> 
>>>>>>+replay:
>>>>>> 	if (!tcf_idr_check(tn, parm->index, act, bind)) {
>>>>>> 		ret = tcf_idr_create(tn, parm->index, est, act,
>>>>>> 				     &act_bpf_ops, bind, true);
>>>>>>-		if (ret < 0)
>>>>>>+		/* Action with specified index was created concurrently.
>>>>>>+		 * Check again.
>>>>>>+		 */
>>>>>>+		if (parm->index && ret == -ENOSPC)
>>>>>>+			goto replay;
>>>>>>+		else if (ret)
>>>>>
>>>>> Hmm, looks like you are doing the same/very similar thing in every act
>>>>> code. I think it would make sense to introduce a helper function for
>>>>> this purpose.
>>>>
>>>>This code uses goto so it can't be easily refactored into standalone
>>>>function. Could you specify which part of this code you suggest to
>>>>extract?
>>>
>>> Hmm, looking at the code, I think that what would help is to have a
>>> helper that would atomically check if index exists and if not, it would
>>> allocate one. Something like:
>>>
>>>
>>> int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
>>> 			struct tc_action **a, int bind)
>>> {
>>> 	struct tcf_idrinfo *idrinfo = tn->idrinfo;
>>> 	struct tc_action *p;
>>> 	int err;
>>>
>>> 	spin_lock(&idrinfo->lock);
>>> 	if (*index) {
>>> 		p = idr_find(&idrinfo->action_idr, *index);
>>> 		if (p) {
>>> 			if (bind)
>>> 	   			p->tcfa_bindcnt++;
>>> 			p->tcfa_refcnt++;
>>> 			*a = p;
>>> 			err = 0;
>>> 		} else {
>>> 			*a = NULL;
>>> 			err = idr_alloc_u32(idr, NULL, index,
>>> 					    *index, GFP_ATOMIC);
>>> 		}
>>> 	} else {
>>> 		*index = 1;
>>> 		*a = NULL;
>>> 		err = idr_alloc_u32(idr, NULL, index, UINT_MAX, GFP_ATOMIC);
>>> 	}
>>> 	spin_unlock(&idrinfo->lock);
>>> 	return err;
>>> }
>>>
>>> The act code would just check if "a" is NULL and if so, it would call
>>> tcf_idr_create() with allocated index as arg.
>>
>>What about multiple actions that have arbitrary code between initial
>>check and idr allocation that is currently inside tcf_idr_create()?
>
> Why it would be a problem to have them after the allocation?

Lets look at mirred for exmple:
	exists = tcf_idr_check(tn, parm->index, a, bind);
	if (exists && bind)
		return 0;

	switch (parm->eaction) {
	case TCA_EGRESS_MIRROR:
	case TCA_EGRESS_REDIR:
	case TCA_INGRESS_REDIR:
	case TCA_INGRESS_MIRROR:
		break;
	default:
		if (exists)
			tcf_idr_release(*a, bind);
		NL_SET_ERR_MSG_MOD(extack, "Unknown mirred option");
		return -EINVAL;
	}
	if (parm->ifindex) {
		dev = __dev_get_by_index(net, parm->ifindex);
		if (dev == NULL) {
			if (exists)
				tcf_idr_release(*a, bind);
			return -ENODEV;
		}
		mac_header_xmit = dev_is_mac_header_xmit(dev);
	} else {
		dev = NULL;
	}

	if (!exists) {
		if (!dev) {
			NL_SET_ERR_MSG_MOD(extack, "Specified device does not exist");
			return -EINVAL;
		}
		ret = tcf_idr_create(tn, parm->index, est, a,
				     &act_mirred_ops, bind, true);
		/* Action with specified index was created concurrently.
		 * Check again.
		 */
		if (parm->index && ret == -ENOSPC)
			goto replay;
		else if (ret)
			return ret;

There are several returns and cleanup is only performed when action
exists. So all code like that will have to be audited to also remove
index from idr, otherwise idr handles leak on return.

>
> There is one issue though with my draft. tcf_idr_insert() function
> which actually assigns a "p" pointer to the idr index is called later on.
> Until that happens, the idr_find() would return NULL even if the index
> is actually allocated. We cannot assign "p" in tcf_idr_check_alloc()
> because it is allocated only later on in tcf_idr_create(). But that is
> resolvable by the following trick:
>
> int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
> 			struct tc_action **a, int bind)
> {
> 	struct tcf_idrinfo *idrinfo = tn->idrinfo;
> 	struct tc_action *p;
> 	int err;
>
> again:
> 	spin_lock(&idrinfo->lock);
> 	if (*index) {
>  		p = idr_find(&idrinfo->action_idr, *index);
> 		if (IS_ERR(p)) {
> 			/* This means that another process allocated
> 			 * index but did not assign the pointer yet.
> 			 */
> 			spin_unlock(&idrinfo->lock);
> 			goto again;
> 		}
>  		if (p) {
>  			if (bind)
>  	   			p->tcfa_bindcnt++;
>  			p->tcfa_refcnt++;
>  			*a = p;
>  			err = 0;
>  		} else {
>  			*a = NULL;
>  			err = idr_alloc_u32(idr, NULL, index,
>  					    *index, GFP_ATOMIC);
> 			idr_replace(&idrinfo->action_idr,
> 				    ERR_PTR(-EBUSY), *index);
>  		}
>  	} else {
>  		*index = 1;
> 		*a = NULL;
>  		err = idr_alloc_u32(idr, NULL, index, UINT_MAX, GFP_ATOMIC);
> 		idr_replace(&idrinfo->action_idr, ERR_PTR(-EBUSY), *index);
>  	}
>  	spin_unlock(&idrinfo->lock);
>  	return err;
> }
>

So users of action idr that might perform concurrent lookups are also
have to be changed to check for error pointers, that now can be inserted
into idr? Seems like a complex change...

>
>
>
>
>>
>>>
>>>
>>>>
>>>>>
>>>>> [...]
>>>>
>>
