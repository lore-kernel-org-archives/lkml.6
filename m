Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85F0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48242653C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fz0gc8p+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48242653C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeFZGN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:13:57 -0400
Received: from mail-eopbgr60111.outbound.protection.outlook.com ([40.107.6.111]:9159
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750919AbeFZGNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61RGXfwJltyA+K4QPusOJeIJ6IvA9cj2dt+knQ3zSJc=;
 b=fz0gc8p+mAroCrNHzFKOJ+Gbj0atS+P4mcR/jSEU/8KU70+/SRxfE3UcWqtfjamYS9/TIMNFrG8Fj/MOAYEiTXbJETO3N1SZAbcT9wkrjy2nYO2ReKqJY/AAzsBZosWeUxGW9emL8QayuDizsLxZ4GNKSJenHVLJ+W3lWufxdnI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
Received: from outlook.office365.com (73.140.212.29) by
 AM0PR08MB3252.eurprd08.prod.outlook.com (2603:10a6:208:5e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Tue, 26 Jun 2018 06:13:49 +0000
Date:   Mon, 25 Jun 2018 23:13:22 -0700
From:   Andrei Vagin <avagin@virtuozzo.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [12/24] proc: Add fs_context support to procfs [ver #7]
Message-ID: <20180626061320.GA12548@outlook.office365.com>
References: <152414474815.23902.6952548431423168966.stgit@warthog.procyon.org.uk>
 <20180619033450.GA11639@outlook.office365.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20180619033450.GA11639@outlook.office365.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [73.140.212.29]
X-ClientProxiedBy: MWHPR20CA0041.namprd20.prod.outlook.com
 (2603:10b6:300:ed::27) To AM0PR08MB3252.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85e55b29-f796-43cf-6163-08d5db2bfc7a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3252;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;3:19CRSH+p/ej9Vm5xkHFIaN2YH5MvpKjrt9r/YqtedsiebdlHBDs6BQWEtJGVFTNnkpvU5JAmh32uWaa//4ZeNtba+QFSR1DDoMBr5rmGT7zWnn21C3OzWOLthbxJOeOyi2mVA6060oPh4xwMRvb/4c2s7S3nevh6Am6u2jycWpURjQwIZB31EimcZOt5GldaEgRwE03PnI8BY77ChAEBJeHA/mGn4/jwyhHlUzWLXdN5gtjxJ1CJSzwwIeGxmnCM;25:Zvy1sQsSJHT/N49LqIifwQQYroWs1ez5NuIJ10hXG/9UMQACy3elmfbjuaWMLEiTLp6EaRX5X4GsWB+FqFRFQQ3U651bpRP+At6XYST5NfVjHPcACE4O42ONvAspk3CsiN6c+ecbEDtZ42zDekMlDyw2lHLfud+18JfcWRWRcb/gDsO2gvncOWIJWN/mq7l2g96HV9R6wgFXxjO3K6POqYHYJnHjzXbulQAYjMf6la2HkFtEsHC1d061qbU9YewxD5FOp5vhU1GFkFi48AzJmjRMpPgEUEWv3mLdXjF5xDfaFUSFekpRKFonXh9EzhA1CWH+t13JljjOJ5VPWtoH+w==;31:1+s+25U7oqxHexQKoG+54z2E3hVDjxubBhMeynJgERltQpR15285lrYRdBmobxX9PfiS6LlSJ7QP6SPRvBD13CISffLhKcOR/gRqL8UZb4+gg4YDZXvDfpTK0kgv9U2tIdny826+tKcBwuPxGBWChPdBemTbViLf3kpskEl5IAKuA+aNdQaQPcbs9KdpnLf3kpbnMVXzkpjHl5dleft3FsYAwB/ZIEka5t3dl/GoJYo=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3252:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;20:+IkssgvfKQiqZtccZ1jrCCDzejGLKJwtWsEN9kcRjjLaxX/WG7vrY3rW1qxSBUi+VkBk9GXkhFe3XyhPW/ppxFtOdabIg77vwX2Hpfl5XM0PAgKmx1s7QGtMPh8XKgke2z1gxjnxkxEdTID3CKvIswan1xMP3aRkjRNAA6dT6hOoimRDzbNwGWwfTk9wrmA8T4gZ7Tw20O3NlnYqfAe2EUGGMyEX7n4JZwsujoKt71g0vkha2aW/E1ns9soJH0p5D0GafGeMuBfckXnwVD7rsBMxvOaGU4MVV2I6ndMHbr8sKwk51HZ6LY/TFGrnbR0psoVVk37fDJrdFYIggvlULbYneYJZNaVxAsNSV4dhe066CiNJRna5WiYFF0hIp4bR0QBKvMibUSAyCRROmeAl4LgjAo0gszuuNYb+xKcWvWPC3IvuiAgDKfi39nqjjt6bQTyLf/jwSLuPKDmqp14ZyIOtKMr3pXIcrYa4WfX0iSmjhGmCfmupVow+R8EP1BjP;4:HYmLVuXfVaOHgNMEtc34XwbUHPUGoZBU+1h+HCMASu9zz+BRQn7CxAcFFsR8kSzIp+JTj3pFEUf6yXjxeV6ZqBMoWE8ZmHAKdcGHFSbC5ugq/yuSVFkjFpIx4limI498jPVCHXUQ6r2aOVyB+YDB4kcZ4+exm3tZhIRIOHjZIS8jCnbhwBpPfK77WElI9P8OSXgU9tGtWyGm4m/scfuThs79KL42NSnjqv/MutOjculOo5LALe0bMISCWgmekQaKy3FSkFbJqWFyE7S6pD6vNw==
X-Microsoft-Antispam-PRVS: <AM0PR08MB325257A10B336CA5FD6D0EA1CF490@AM0PR08MB3252.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR08MB3252;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3252;
X-Forefront-PRVS: 071518EF63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39850400004)(366004)(376002)(346002)(189003)(199004)(66066001)(47776003)(6506007)(956004)(446003)(76176011)(476003)(478600001)(386003)(486006)(186003)(26005)(6666003)(86362001)(52116002)(7696005)(6916009)(11346002)(97736004)(5660300001)(3846002)(2906002)(23686003)(6116002)(16526019)(4326008)(316002)(53936002)(55016002)(1076002)(50466002)(68736007)(229853002)(33656002)(58126008)(9686003)(8936002)(6246003)(16586007)(305945005)(7736002)(105586002)(53416004)(106356001)(81156014)(8676002)(69596002)(81166006)(14444005)(25786009)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3252;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;AM0PR08MB3252;23:zXyKkco4sL1CznR9GQn3R/NEADViM7aUwmQ9s/TAgxO?=
 =?koi8-r?Q?8rPMt3cPzENg656XTBqQLVrUsJwkWMG7AdkZ/sNh8cgVMiGL2Ff5D7U03sgVR6?=
 =?koi8-r?Q?zyrd+nlXIuxtp3RfdAcJ3ogN8KzxvLKNeTZBLx540H21XQJJatD/0mLJAOKG09?=
 =?koi8-r?Q?f0vqSv90GvhIQ4MoYYETqshMMTq9irTjIzXbHTiT4tFhi/kRubMb+zCv7P0tX2?=
 =?koi8-r?Q?PTXhiJtWfw9JZYCJ+sybp8J+vQfR3wRrj0/ZuQ5Yl+TeA7Wd0V3VPJBbko/v1u?=
 =?koi8-r?Q?s2iyIQcGuk2cRaqsFNMKLrYU6HpV2s14mTN1ko7uh3feVYEfN1VqjE69+nFgcO?=
 =?koi8-r?Q?gwfN/Lx7+zoO0RjepSkwc3/JlYEsGEXcOLM0BLb/AfJZWI8eprFKy3+1eCSSdo?=
 =?koi8-r?Q?hYPgfbLuYhpLOwjTQjsOJCrn2okvX8B13cZ6+JG6s4d9igv8Z72GZzUitxjKpA?=
 =?koi8-r?Q?mPnYQVnbnQdPkHvd0QpxbikfSlWyjBqrIhB3TbZ2qDTNYSasLC6pIxETWvruaF?=
 =?koi8-r?Q?F90FIZQWLvORQXg/hnlujd2CrVb86vWLjAK5AOdhKHJ5+a7Y64g7/Ohipau1+N?=
 =?koi8-r?Q?TIo7kNgZUbI3PJrNr9mkNGadmEskqNI0imNzDr3satyXpHR+R77uqFUsnTudqS?=
 =?koi8-r?Q?neOJtazxkpoh/D9YmtiaE3/F31HI3tArEFyTBchbrTDdL2Smiaios9WJmgC7jO?=
 =?koi8-r?Q?ZEBGydCQx8qtX3/lBRTsXKJJ86WxADluvaY2QDRNuDs8n6XBUZluriKDlRcC9e?=
 =?koi8-r?Q?qLBzLbVkPXimCVuleNXYUK1XTul/fio2ElcvKeGw8xHTmHufh7j4F6yYzG0Vef?=
 =?koi8-r?Q?PZXhyqCVX3nORZFZRmHx2c/xOgcAJ9vm3ToystrBgT+Fc2ddwCZNW6Idc7nkD8?=
 =?koi8-r?Q?QGU0iBOE82OATwvtmakkiJ811cLMGQv0nRgCVaIEm2WLvtMt5ukhjeNq0nbWeG?=
 =?koi8-r?Q?g20RscXrLureJnGrMQCJu4tUGhH9BrFudBlNv6klm97J8XvSAetIVpNnJOo6t2?=
 =?koi8-r?Q?5Hj/cs0E2N+WfAOKIi7N1LQyQD2mmTzksAEPCvub638nNG8FmnT7TyIRH46WNx?=
 =?koi8-r?Q?GTWheMsUOuRMC0XinitoaWQUi3QCtUp/Lt3z/968AY38BYR4c+nsIJSYBigGVc?=
 =?koi8-r?Q?QW7Tr+bFY9V0N9k+eCES7MnHBLF2BbIjOffxWuWqq6AdnoJZJLcGka+PLAf2ec?=
 =?koi8-r?Q?urkG0h7GpupZuBSw8u3fB77sXedxMqMOoo2CJUtygKB7cB4mqcAlCpnDUFZo8m?=
 =?koi8-r?Q?oAFpwbt4jzBILU3nCAw=3D=3D?=
X-Microsoft-Antispam-Message-Info: dWqeraKT9ePOvzG9n1SMPB+dhbVxYso/BvPmTTWlakm1myLxXVKTR6fgoDHSHMLYAHE9f0eVtvuDdRtPj6hdh5pbk9yCkujfD0isvP1sYikLaHpG9GPc6wrrcpFmSFBupGUDZr1qX6wq582z5JsrT4R9Nx0S07gaTjs5lpbMDL+gdSH2+IeKioxvul/p70QnqQRpvjT5VqRbuIB/wMaOjuHoJ/ZBmj5RwwS5yK0D5gFQCRcvxSkfzJ+SLIpXIOkJRnHGRYLQPiOVAsNgGEUCgcupa4NNimERSuOdsyEl8hyrT+mSjanA+QNdU/hgHLa1/74P+EBuzHwYTJL9vUYEyTK4ph16WsF8M4TPs7VdZCk=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;6:W8XvjOkDUDBZ466rqU8nvMH7thgNK/vAmmWKNGsbIvGNh7u91SGUwd06VEV4pWyEvaUBMpJ2/UkranxzhGviK9UyeWQ5vasi3PYgxxQ4NizYhXmTyrK6AOQolo6vJnq+wC3QA6z2xEZOutAqgyOsuv9SJsugJBhqhYOc3FIy+8xIsQXR3U46uLm1Y1Suq6Bq+6pOChc4/aTwtPdlEDrkecP1Tur6mZLjkzU9T6nC/CZNqla29HW6B91Djk2GCk50PHovIjhLqfJBZSWonh3glF1z7uVsmyL0RsXJZkRA8QtpmnfCHSSbzwK3AvW4rWzfmJPDok4Zf3ccke7sdQtXPUwSpghzcquG5S59jHmpYQv860BGIzopUb+jtYowNZlrxCcGCheUXua/dqvPueQhxx7irU7oSL4SqG2yOhjyoxFyzPMu7lLKRcRrGc/0ji9aqmjhoXvvXddifR4cnwTDfQ==;5:TuAf9OEHu5Qdb9/14QjLiQZvohgUWXakCDyEXxYQgCPxfxIH2jdNEWspTfbSJYMIEDy5KXonvJq8ROjug0uK64enLiJXk8DD0yiHU7zq4A0q/IosxDU3cU2pcaxD387DncetPKH4FWBSEH06US3W2V9BnOxkXZeEjC8ZdR8ORoI=;24:gcZFmfg5R1eVFWDAXukVLpseEnjCdookFT9zD4QUD6Y0Jy/dPmAz0A6bMfUe2OfaLnz5o1JgIQ1UTHW0q1HK2dkpGL++ISOhl2udAhvGNTM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;7:djQYhMjcuomgZPz4FL8v2rQJlqyFqbRDvGhFjjKpQtq0QnIrp/PUqE2Zt1b4qQGrQSa9nmiR7VRt9rANcLZHGIhBOEdGS7Ifq2j78AKpe3b3xznuIXJTKH+MpNQp71oNM9uSNgT/E80z9Yhs2Qgjti9vu/kgsh/dH4iKL9+YvBZqg7huFQ/dtB1bnZ57A2DL4a9pPUiMo0xpfvJKHqF9Fj9mlrih/jbHdeNcfM4W0NBzEG53dKKG/6jKHG0xaQEH;20:nsj7ssyMSZ4lzjoHKD2ZpD/yPyEaO5ZGuXTtznC/M9g5KqwY1uZnfjocvyrf/wEY7r4zeP8VmwT+lcQgvhAz7hbqzeRDZPTiIpeI8vsjb/l/yyDlcOjYHF7jA2bYx/I7OfEo71PPL4lvqjnpVdqTh9nyp1SXUtzqUFPIoZHNO7Q=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2018 06:13:49.2342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e55b29-f796-43cf-6163-08d5db2bfc7a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 08:34:50PM -0700, Andrei Vagin wrote:
> Hi David,
> 
> We run CRIU tests for vfs/for-next, and today a few of these test failed. I
> found that the problem appears after this patch..
> 
> >  int pid_ns_prepare_proc(struct pid_namespace *ns)
> >  {
> > +	struct proc_fs_context *ctx;
> > +	struct fs_context *fc;
> >  	struct vfsmount *mnt;
> > +	int ret;
> > +
> > +	fc = vfs_new_fs_context(&proc_fs_type, NULL, 0,
> > +				FS_CONTEXT_FOR_KERNEL_MOUNT);
> > +	if (IS_ERR(fc))
> > +		return PTR_ERR(fc);
> > +
> > +	ctx = container_of(fc, struct proc_fs_context, fc);
> > +	if (ctx->pid_ns != ns) {
> > +		put_pid_ns(ctx->pid_ns);
> > +		get_pid_ns(ns);
> > +		ctx->pid_ns = ns;
> > +	}
> > +
> > +	ret = vfs_get_tree(fc);
> > +	if (ret < 0) {
> > +		put_fs_context(fc);
> > +		return ret;
> > +	}
> >  
> > -	mnt = kern_mount_data(&proc_fs_type, ns, 0);

Here ns->user_ns and get_current_cred()->user_ns are not always equal

> > +	mnt = vfs_create_mount(fc);
> > +	put_fs_context(fc);
> >  	if (IS_ERR(mnt))
> >  		return PTR_ERR(mnt);
> >  

> #define _GNU_SOURCE
> #include <sys/types.h>
> #include <sched.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <sys/mount.h>
> #include <sys/wait.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <stdlib.h>
> #include <grp.h>
> #include <linux/limits.h>
> 
> 
> #define NS_STACK_SIZE	4096
> 
> #define __stack_aligned__	__attribute__((aligned(16)))
> 
> /* All arguments should be above stack, because it grows down */
> struct ns_exec_args {
> 	char stack[NS_STACK_SIZE] __stack_aligned__;
> 	char stack_ptr[0];
> 	int pfd[2];
> };
> 
> static int ns_exec(void *_arg)
> {
> 	struct ns_exec_args *args = (struct ns_exec_args *) _arg;
> 	int ret;
> 
> 	close(args->pfd[1]);
> 	if (read(args->pfd[0], &ret, sizeof(ret)) != sizeof(ret))
> 		return -1;
> 
> 	setsid();
> 
> 	if (setuid(0) || setgid(0) || setgroups(0, NULL)) {
> 		fprintf(stderr, "set*id failed: %m\n");
> 		return -1;
> 	}
> 
> 	if (mount("proc", "/mnt", "proc", MS_MGC_VAL | MS_NOSUID | MS_NOEXEC | MS_NODEV, NULL)) {
> 		fprintf(stderr, "mount(/proc) failed: %m\n");
> 		return -1;
> 	}
> 
> 	return 0;
> }
> 
> #define UID_MAP "0 100000 100000\n100000 200000 50000"
> #define GID_MAP "0 400000 50000\n50000 500000 100000"
> int main()
> {
> 	pid_t pid;
> 	int ret, status;
> 	struct ns_exec_args args;
> 	int flags;
> 	char pname[PATH_MAX];
> 	int fd, pfd[2];
> 
> 	if (pipe(pfd))
> 		return 1;
> 
> 	args.pfd[0] = pfd[0];
> 	args.pfd[1] = pfd[1];
> 
> 	flags = CLONE_NEWPID | CLONE_NEWNS | CLONE_NEWUTS |
> 		CLONE_NEWNET | CLONE_NEWIPC | CLONE_NEWUSER | SIGCHLD;
> 
> 	pid = clone(ns_exec, args.stack_ptr, flags, &args);
> 	if (pid < 0) {
> 		fprintf(stderr, "clone() failed: %m\n");
> 		exit(1);
> 	}
> 
> 
> 	snprintf(pname, sizeof(pname), "/proc/%d/uid_map", pid);
> 	fd = open(pname, O_WRONLY);
> 	if (fd < 0) {
> 		fprintf(stderr, "open(%s): %m\n", pname);
> 		exit(1);
> 	}
> 	if (write(fd, UID_MAP, sizeof(UID_MAP)) < 0) {
> 		fprintf(stderr, "write(" UID_MAP "): %m\n");
> 		exit(1);
> 	}
> 	close(fd);
> 
> 	snprintf(pname, sizeof(pname), "/proc/%d/gid_map", pid);
> 	fd = open(pname, O_WRONLY);
> 	if (fd < 0) {
> 		fprintf(stderr, "open(%s): %m\n", pname);
> 		exit(1);
> 	}
> 	if (write(fd, GID_MAP, sizeof(GID_MAP)) < 0) {
> 		fprintf(stderr, "write(" GID_MAP "): %m\n");
> 		exit(1);
> 	}
> 	close(fd);
> 
> 	if (write(pfd[1], &ret, sizeof(ret)) != sizeof(ret))
> 		return 1;
> 
> 	if (waitpid(pid, &status, 0) != pid)
> 		return 1;
> 	if (status)
> 		return 1;
> 
> 	return 0;
> }

