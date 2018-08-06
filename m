Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA78C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0EF21723
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="KeZwSniz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0EF21723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbeHFL0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:51 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:36238 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728475AbeHFL0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:50 -0400
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BDsE000403;
        Mon, 6 Aug 2018 04:17:44 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp0180.outbound.protection.outlook.com [216.32.181.180])
        by mx0b-00010702.pphosted.com with ESMTP id 2kn9y5kk7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBsEvnAqao96YrSVCTjgxikm0AUf2icoXxyE0pbFMwY=;
 b=KeZwSniz8H2rlXAuK6Nder+m72MLIW9ibaNT+ScH/PFq3niU2Ba4hzWWqhS9HQ/E07+BzWdY4vhgyXYA4kEJ8Scpr1Yb9oQ3iuCYKBcQ63S7a/e33b9aLF0os47fO68abYBFASzcdrdB8ncaFIsUA9JcPOh++Xwqpd1xdnK++DI=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 CY4PR04MB0966.namprd04.prod.outlook.com (2603:10b6:910:54::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.18; Mon, 6 Aug 2018 09:17:42 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id BAA31302D67; Mon,  6 Aug 2018 04:17:38 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dvhart@infradead.org,
        syzbot 
        <bot+2af19c9e1ffe4d4ee1d16c56ae7580feaee75765@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, stable@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH RT 02/22] futex: Fix more put_pi_state() vs. exit_pi_state_list() races
Date:   Mon,  6 Aug 2018 04:17:18 -0500
Message-Id: <31e791651f8d58a70490d8a6bb0809521f64ca6e.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: SN6PR1501CA0002.namprd15.prod.outlook.com
 (2603:10b6:805::15) To CY4PR04MB0966.namprd04.prod.outlook.com
 (2603:10b6:910:54::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f000c027-8b01-4a3c-27c4-08d5fb7d7691
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR04MB0966;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0966;3:uwiJyUeUN98hv6fUOpGSJLcJm48H8dujRGLkVU/n2K+maeU8OCSZLZJGh4DD3tDLb3OGkq75ALvai6UMagFv1NEN/gLIuowK3Pk/Bn9w0LHXkmxSENt2fPhkCUPblueFE27DtMpWVOXc6QDQwn7pWMweIb9ab7ufMFhp0mFLRXdl2eLjC3EUJVceVi/+mLOHgIIcRFN+ALU/E4kkhKjKHp4A566nE9pF0tB3h1tMtXF+4kgmtFBdhzomjQEdDFNp;25:hB/FSuik1Ja6CC/FjD5QBkZQf3aaekptrHTNJ9xN/8298zDsTKTi5NYDrvWS1RLt7lzoxikQSh1gRnPS/Ijjlw4H9VgsFZ6tRYj0y4UASU0XgsUByYBHP9VNSl9Z2rpDfl04KTjTI6whC9AYtOLVrdSwa6H9ICqIEGREoeMCDtk3btVgyANsBEVrUy2PcOXXPsjVpTJGrwQtgRlQnKrZANnQ3t2FgFSZlkP9+dD5QTYjHKowHMIbFHKpF9UWvyzFiwDNwu8IhU5uygLXv8+GO6P27Qrc4qbGLVTb+XIlll9MRWGoVVEgPTDfLphloGg3xJG0Dz/FrkIMJW1K/kWkww==;31:qECfYZtdHNHm4Pk8HNL0d7O4zyc3xnGN0ALcSg1WFdw0S/sC+YbxJNaa7OySvVKolz5j9xV23ZSvbgJ6goibXIINSgJ22NXQ00+cEWSbHmAy5nOeaWCj8+JTcuLJx3iHob8yq7gWejPlPb7Y7v4X7dJ0WH6n/XwdDdhmjPs7z6JPgouMqCiELGoJQI13qwsgJ6iXEL3W6BaL3F9pUxutqrUF9BdvviptYBPR8FBfqx0=
X-MS-TrafficTypeDiagnostic: CY4PR04MB0966:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0966;20:/PSRzdFQjbehhm5PnIABrKxEfBXV8AT3axD9WSJ8tkYKkb8EFmFTX/9DzjT1509uBk0DmY9Szi/Qj0/DyRPPHX5FgIqsZfmpDz7jNiptGB8J5StgPdngaw0vQkWoZpDOMv8AZEX0wrpvwCpCWT2v1NH4AOHPK2pV1Z047ZEkloaerRssKiHzuBnNM4UBCtDIh/TNHPdgz8F+Hxl+qc0fZc25wD1LAXsOUOMCGWCS0gBvc8WV9bBS5dZZtI8KM7nIDKXr7tqBfMnQC4SBjoQeATZGcwLR5CRNVw/QWSmq2AyCGnCt93KuQ9LxJSCbNKOx3EJKVtnu9A7B/Ub9eqtp2MVUXZQY48v0wdHmJBzXVE6G1/P+mQyzSpkf5UW9bFjX+HZRpRe7ETLggP+lkRLPmbPxwj73J8Q1E/sJiE2wQRwSheRKB4NfYSUtXNPEvOx6JdvKUNZ8QHfqkoAogFRm8q4XFwLUx76Im2lCdtZ/ZOJxe95Tieowb8F+fGgdc8lkTF5aK2J6Koxyy8ERtkr1prJSgPC1+RZax+kQJaFHHeIg4+ipw9cgesnh2exVdqjqFQerEOQNSfdf02tO6Hy2JHBZeZDMTtXYTku9rli4q6s=
X-Microsoft-Antispam-PRVS: <CY4PR04MB0966B960149DBF633F9197FDF4200@CY4PR04MB0966.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(215639381216008)(9452136761055)(211936372134217)(42068640409301)(153496737603132)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR04MB0966;BCL:0;PCL:0;RULEID:;SRVR:CY4PR04MB0966;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0966;4:Sc3H75xMB8F3cMF9/dJ25XYxhY6SuXDtJhmMy6w5hcH4/enhyGqfJfnDCwCEToML/sr6wxRYGbCDZeru8qats24qmqKTFYiiEqIccm3NsV/ZNRUw9eTJRbDIjjFmkXrcTRKRGv8GAX57YE/BOH94esJDUqutM8EmFb4W6+A/+agYAWX3BWRh0feSbQJyRJTfmDr1Zs4iicZ6nw3TTrVDsVolFrd/0A6MndAVD42xMAKsOkTs1sWedZ2/uFmtGYluwfTFErFRQaKIw0186w2CWCJvKwKolYpTwFrrIWzE9QYKH8XjRzkaLJ1mFYpi5XnqVJF08tHgyvLTJHlDzvIQnFYxDNLmrqlEzPwuT9i0axU+30C1KBIbYQGbUEft93HyLp+wM0a6Vg52L5nTy8T8tG3pK0J3bgkeun2aP/smWGTnebr0ZsNhBGn0bjdSKs3eaXM3lUWhoD7AzFoZX1X6TfbOsc8ueGTiCDeJPSa89KQ=
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39850400004)(376002)(366004)(189003)(199004)(42186006)(51416003)(52116002)(316002)(966005)(53936002)(122856001)(76176011)(8676002)(2906002)(81156014)(105586002)(81166006)(106356001)(4326008)(6306002)(16586007)(478600001)(54906003)(48376002)(5660300001)(50466002)(66066001)(6666003)(118296001)(52956003)(446003)(50226002)(7416002)(90966002)(6266002)(68736007)(8936002)(47776003)(2616005)(26005)(186003)(11346002)(486006)(476003)(386003)(14444005)(3846002)(97736004)(36756003)(7736002)(6116002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB0966;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR04MB0966;23:dXljsLiQ18turgLso0K8NyCWp8HmpuF9Gb7oVGGqu?=
 =?us-ascii?Q?SdmZkT/+9IN6+V68RS8uvK/U0D3VfzrFqZ9ucVFXt8Hr6Bn8gMPqBgjoU7bJ?=
 =?us-ascii?Q?mxctHuZyhx+xzspgYZLPRVQnMAKMupdJgQG5KzNjBP0SOPfofy6eAde3OAiF?=
 =?us-ascii?Q?Lc0emdMDG7KXi8xVcL42H7RQ1jxz+xL3JYC4Ftpb5w7poT2ZIkgdCCwafQ/m?=
 =?us-ascii?Q?d998gxFJ+UmxNQx/Y+TbN45+CIf+eb8OKXU9BiAAhrRY2uJ+wx+qhqqQtDud?=
 =?us-ascii?Q?0CgXMBizpndZdbnpTKipBh1qHCv/IrxFyzv81v5+24TE5CNDGrh3IiKsakDQ?=
 =?us-ascii?Q?wOBrqmTFlz1nFqkl5JFWCsQXPdZSCykDkvsTXZ/M7KBuMIg67BFZ13Lyf2fa?=
 =?us-ascii?Q?FmEnVQIoeQyXDEewkFV4IP/MiM6s+DrJ82p3HIFjwpBEXjHAnst6HhfvvA2U?=
 =?us-ascii?Q?sjFrmHaBHQ4yan7hbMssw6eufMwF0sNsONdV3BRqktHth/zxEzvc5vbyMQcW?=
 =?us-ascii?Q?PMw+yuJLYROQyT8dyFXpWR59OKl2IFgaxkwfSuhl8lH1RAvpuXvxDYiEHTpB?=
 =?us-ascii?Q?goYcDWYn0ux5einkdK7x0ocYp39nq8jTS5cqd/VZ3Fdgu6pU1gdUYuvyac42?=
 =?us-ascii?Q?88Hj2AAzJErHE31E88a2j0fqeyxhwmnVXpJo1/mj+MnQf72WOmE1akiWVJ+X?=
 =?us-ascii?Q?IizfgJR7rmnS8j+szL5th6davY95wgL4zhsryaFb21Qb0S56IgWKx/+3PsfV?=
 =?us-ascii?Q?2KPnTn8QqDrMOX1Su5FKc0ZRv4OJcWdPEdg/eY4+hUr17m/gfV0dhSi8ypg8?=
 =?us-ascii?Q?736dZgKIJvF+mjDo2x3NHXXeTpoStmwqIb+i42jgZ3jj44Z97rxz4iwsACov?=
 =?us-ascii?Q?FzUJE//kRbgP/fK7TJOobBOMY/ORgr4GGjpWna/8ETt3YiN5YMVQv0cTWdgc?=
 =?us-ascii?Q?obYbS0Sql67t9wMtwKYUCE9XVBO4ALXYHa+vJPJ6mCE1AxeI9HoIjOhHE93r?=
 =?us-ascii?Q?vf2lsNF3MvpxtKbtrmXK9k+9jD7hHSQQaNvqhoDoc2NTKi+GrJS/bNCMRYvd?=
 =?us-ascii?Q?z0CGHCHFqrl6Qdg7j0RStAY9MSuOUAS8DeNSK7TILI1ILft9x97QtAuSWd5q?=
 =?us-ascii?Q?NRaXy9gmDL+HMc+2GqXPymcS+FdL9RtyLNMp9BEGNKWmhGmyW0fu6USAocyy?=
 =?us-ascii?Q?GgQypMqB+zoDIfFz3IGNGDvuIi5kqQsV2wnYGT28ZEyYqmt/fmFwF7OuA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 9a8C/YqkIn7F4VazWxS5cR03pHMezvmVuzAF3nxqqYYyzrWUxeOV6OunTTMXisrtfH56ujSUjpeViKr+gRqPAYF9O/kcnfuozgRqgDiPG4PajeEKTkrNR1r+WcV8AbuYnUkaNKuHwfo/0pMcgrIZN4ZTlNfR36KzFREbtjgaVDChX5qundsjckc/0Fa1s47ggyMEwlhRyL6jSfBreulYc0TrywTZqm6qGjPrEffuRjbDNueMU5JQesjQI97s1SCt/kWmMFKeje/UDial+m00GTo/XUju550PEqznHUU4Q1+x1eLVUVo390uXGsvdOhvor98lmIaXhj9auAqBYHzlrzLScgB5YAd5WFMdIw3Ppy8=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0966;6:dgsyWdMrdDAylRdtOrmhSzouI8KOYc10fR5pUqqP2vL0BjPuco3WaBSiCLrIbn1Rej49z5ucWhAqlcflOK8WRh1E172ossHJvet8nfl5O9C0d+4KQ5psjaQbIn4moQ7MhZ7euaKzWD5epSVZktPrNZ2J2lKMyYHZ+UiB4HpuU5VuYXSKXVCE5ZJb8WZF0sODQfvPj3NxZ4PF/ylcKATnkVcR4NfhbEvrbaC/20UElQfqUAzxTHQDPrf9F5AoXSitl5B2Aob8kw4usr+mu80TRTwrlW2X8DYkJt5+CJenNwFgUR3Js8R4hiewVKg7Jg+1JqUAZ/SCF7UfDF21XyKIZWcB+yUCxsvSvPnmwC1prpxhCPt5728CIT6vy2JLHflEm7JJQ11ZhwO82tmb54oNZ/dAnwNBrW916soXR1/bOZYDiibCz7elUROzEFWpdkTYfA++ADnn0D3H+1M1o0m+Mg==;5:r/lbpQU/UA7N70G8hOhU/sNvYxbg+NeLmt2kCPQmNQ9RjvVlHV0J5stMMJpCp7Cep9jKrO2NB+7Y9HCKFG8dX/aKRnjU9gv+c8HjWI4AxQqPxOmfQO+P0iKy7GfsjS7tBKCGB+UGaX+JnSVcsMNHQ/KKOxTeWo8kuM/xmO8wuZ0=;7:e6AI3EKuTE1gK602stC3cj4XY1Nu/mw3sJSNV0UNGfrPhkLN67nliAXOqUP3LLRme8QLr80G6lMTwjLpcn5gDvGDAykDyEBE7/yJCJGkpqt0gv0oXnS7HKhj0tH748j6yQNfHK3UVeyEsQwnAdWMhU9pmtQJw/6RNigq7SjAtM5jtFJLZLuJJ0CA7hD4/BHr2Om+QJDOiVmOk5yJDILDrtryOejels4pLXM36xuubNvLM2f7kIGypjF78pZNXAzt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:42.1041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f000c027-8b01-4a3c-27c4-08d5fb7d7691
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0966
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
[ Upstream commit 51d00899f7e6ded15c89cb4e2cb11a35283bac81 ]

Dmitry (through syzbot) reported being able to trigger the WARN in
get_pi_state() and a use-after-free on:

	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);

Both are due to this race:

  exit_pi_state_list()				put_pi_state()

  lock(&curr->pi_lock)
  while() {
	pi_state = list_first_entry(head);
	hb = hash_futex(&pi_state->key);
	unlock(&curr->pi_lock);

						dec_and_test(&pi_state->refcount);

	lock(&hb->lock)
	lock(&pi_state->pi_mutex.wait_lock)	// uaf if pi_state free'd
	lock(&curr->pi_lock);

	....

	unlock(&curr->pi_lock);
	get_pi_state();				// WARN; refcount==0

The problem is we take the reference count too late, and don't allow it
being 0. Fix it by using inc_not_zero() and simply retrying the loop
when we fail to get a refcount. In that case put_pi_state() should
remove the entry from the list.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Gratian Crisan <gratian.crisan@ni.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: dvhart@infradead.org
Cc: syzbot <bot+2af19c9e1ffe4d4ee1d16c56ae7580feaee75765@syzkaller.appspotmail.com>
Cc: syzkaller-bugs@googlegroups.com
Cc: <stable@vger.kernel.org>
Fixes: c74aef2d06a9 ("futex: Fix pi_state->owner serialization")
Link: http://lkml.kernel.org/r/20171031101853.xpfh72y643kdfhjs@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/futex.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 47e42faad6c5..270148be5647 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -899,11 +899,27 @@ void exit_pi_state_list(struct task_struct *curr)
 	 */
 	raw_spin_lock_irq(&curr->pi_lock);
 	while (!list_empty(head)) {
-
 		next = head->next;
 		pi_state = list_entry(next, struct futex_pi_state, list);
 		key = pi_state->key;
 		hb = hash_futex(&key);
+
+		/*
+		 * We can race against put_pi_state() removing itself from the
+		 * list (a waiter going away). put_pi_state() will first
+		 * decrement the reference count and then modify the list, so
+		 * its possible to see the list entry but fail this reference
+		 * acquire.
+		 *
+		 * In that case; drop the locks to let put_pi_state() make
+		 * progress and retry the loop.
+		 */
+		if (!atomic_inc_not_zero(&pi_state->refcount)) {
+			raw_spin_unlock_irq(&curr->pi_lock);
+			cpu_relax();
+			raw_spin_lock_irq(&curr->pi_lock);
+			continue;
+		}
 		raw_spin_unlock_irq(&curr->pi_lock);
 
 		spin_lock(&hb->lock);
@@ -914,10 +930,12 @@ void exit_pi_state_list(struct task_struct *curr)
 		 * task still owns the PI-state:
 		 */
 		if (head->next != next) {
+			/* retain curr->pi_lock for the loop invariant */
 			raw_spin_unlock(&curr->pi_lock);
 			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 			spin_unlock(&hb->lock);
 			raw_spin_lock_irq(&curr->pi_lock);
+			put_pi_state(pi_state);
 			continue;
 		}
 
@@ -925,9 +943,8 @@ void exit_pi_state_list(struct task_struct *curr)
 		WARN_ON(list_empty(&pi_state->list));
 		list_del_init(&pi_state->list);
 		pi_state->owner = NULL;
-		raw_spin_unlock(&curr->pi_lock);
 
-		get_pi_state(pi_state);
+		raw_spin_unlock(&curr->pi_lock);
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 		spin_unlock(&hb->lock);
 
-- 
2.18.0

