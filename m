Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E53C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D90E205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GT592zY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D90E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757205AbeFSUZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:25:47 -0400
Received: from mail-db5eur01on0128.outbound.protection.outlook.com ([104.47.2.128]:8992
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967238AbeFSUZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxDLo5Mh3XDbMp4Oyyjg6RY7N4eoYPVm2QtObbs9iBc=;
 b=GT592zY16M0Odir1rJ55xQ/lJg4fka6P4ccqQZ+AmG+HAZ9AaWpPV1S64rQJkTllGHh7rgKzGYkNclbo7eXPFXrqUQ/7XrRIT1Hx8a+pDPnZNKJBmKhEa9YUua63KPnJo9GK4Ex+9rZ/N5a1mhijJV3f6uQaMsJ69qaLO3M5FGo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
Received: from outlook.office365.com (4.16.175.162) by
 AM0PR08MB3252.eurprd08.prod.outlook.com (2603:10a6:208:5e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Tue, 19 Jun 2018 20:25:31 +0000
Date:   Tue, 19 Jun 2018 13:25:15 -0700
From:   Andrey Vagin <avagin@virtuozzo.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        Kirill Gorkunov <kgorkunov@virtuozzo.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vasily Averin <vvs@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikolay Borisov <kernel@kyup.com>
Subject: Re: [PATCH 2/2] fs/lock: show locks taken by processes from another
 pidns
Message-ID: <20180619202514.GC3159@outlook.office365.com>
References: <20180608142712.32460-1-khorenko@virtuozzo.com>
 <20180608142712.32460-3-khorenko@virtuozzo.com>
 <ca07bbc1a20d1429ce47561d9d235f12ef51dcd4.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <ca07bbc1a20d1429ce47561d9d235f12ef51dcd4.camel@kernel.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [4.16.175.162]
X-ClientProxiedBy: MWHPR1701CA0005.namprd17.prod.outlook.com
 (2603:10b6:301:14::15) To AM0PR08MB3252.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdb26c1e-57e3-498c-2b6a-08d5d622cf0c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3252;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;3:S7umfqoPwa/FYrkslfuDzQucnbYTnHPyO2Q3el2pF9FNQHMPaVi5Fan4TaeV7yR/W4GQddntsur5nmqfNvxlB9iJPSdqAdtuAaqDuiDeBUedCoOgCsqP0W5K/CRcrPyukQrSSDHFj86mKUKDn/HcSUIo2RmNsw8Of3IqBM0JU/quhvECt6jqMMQN894ikT50EmmB2Y4cKBRMzBTgLqS92TcvTAjMq3aqMfHQwRjC5kcHcJIQRw8Gr2Sd3bH70NC0;25:++0oGzvRSX7ZxZS59q94QR54HFMnJGhX6N5GDWHf7CL6DQYSPOp29XGnMW1ChdtcpD1R/Q0AtUt+R3RB5H9wuE3/+Cd73BRHxqOr3xEZU8qRhiTxD55e+0gYg6DNTLnlFa3V9bfeymbzCkTIlkswqgxySd9Pza/N9V9rPq5izFdOMuWH+mNHzF2rjKWkfcbi0wVy8tc31hLW7JkooMaHadrbv7U+TuhOqebFO0TxgAfEpcQOzX1sLYPUQgwx+Z696ohyzzt6l+jnCVoz3Yi38SzRPrUVq6wYbQGzv8v7pRW9kqYuln5PovetkWzV1k3JbA0JDUEKi55l1CyfeEKLxA==;31:KvJLMYE6ia3glsXPbLkKZOp+UM/gj8xhHtoy1rgZj7IivBeUmTGY+WwkqBIHv7tMSn68TxLwfbsDlQU5VtXw3RAGnSnMHTY+QwjqWlbw0HPW0HhX0OAExrd1GvXd8AIHScFmECf881yPyraR/OZ2bGPnNXutqZMGNWiDThrZQl7oHnOlfZi/Na0zmL/vC3M3vxeFnMZHgPNaGR5fyAuE0tSN/JxfR10tNiZVFv2KhAQ=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3252:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;20:cWvh3F27XJq8ZFiSPitSW3/5UwzjdAcRYxbkEopRSarsG6B5wg9neLd+EYNStOVxxqNF2omWUrgsDJbAP2l07hnkkQ81nkFBMzgJIZpNdbVGRgjAL4jlmjSNNQ5A8M5rf/6TN+rjRkgBcl/11rVPGZfi/Vz6gVEnQcVMOv7UYS2MWiNRtqysWZuM8UEo3MtB2KMQmbA5+zJgWEBewS8IPHk4BmFTGvZ2iGrueZ/8kaiJswPlq4JOEUBK/a+5smt8XeeokauPPjpfczALte/KnnelNwWHNhfw54q68ZJBAky6TpaX1hAt5hajdP5TMSAnxJh4x7jBhm9cbsSeFFfEwDLPzy2rsnZVs42Gar4jsohur4l0y6+szveE9rnrY01IkBAi0cbIWydzeibr203paxMms6lW3+ahVGFiZWglyYh1cPNoS0BxnAPTKH+CwFKMPYnYwM57rcMJrmyKGx5N4uOi7Tio7q0lW5mHFpOmUPP3XEyo58Nv1d6wSZFgEzjd;4:vE5MRmPdHHJqHulJ+K7WXLobEqcy/IdGFvcXHKIYU5JxyTeHmcGwwdrGjLUHigx0ZNk9hF16XakiUPauMUog6B+LCMO+JuSWjblmiAAtNMqeusdYHZeL8rBormH8G2MwXQfPHNvngANnsXHaU13ToxXa29u43+UO60hZEVVASYwSudKBwXDdqx2J+29s1fmlfaHiZRIy0TwAK6A7Yv3uUB03VXVJR+VyfhMwM4bA2LTrk+bSXaUeTYpT8h9K7Vhnvgg/9d+qlMXCDTxE2s/Bwg==
X-Microsoft-Antispam-PRVS: <AM0PR08MB3252EF1ABF1ADB4EB5BF29A4CF700@AM0PR08MB3252.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR08MB3252;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3252;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39850400004)(366004)(346002)(376002)(199004)(189003)(6246003)(486006)(186003)(16526019)(69596002)(68736007)(23686003)(1076002)(47776003)(4326008)(66066001)(86362001)(6116002)(476003)(956004)(53936002)(97736004)(5660300001)(6916009)(6666003)(478600001)(54906003)(26005)(3846002)(53416004)(9686003)(7736002)(16586007)(305945005)(55016002)(52116002)(7696005)(105586002)(6506007)(59450400001)(386003)(76176011)(2906002)(316002)(8676002)(81166006)(81156014)(11346002)(50466002)(25786009)(446003)(8936002)(58126008)(37156001)(33656002)(106356001)(229853002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3252;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;AM0PR08MB3252;23:0qMWhqKfVSOvVaY2fLQUsm6Wm2kVDJyDBqSLTI+iAuj?=
 =?koi8-r?Q?71L+vkn1i3kdT8uft+AYDvVQB0cde1zd619dYOSTBVxfJyRjP13t08aBY7rqGX?=
 =?koi8-r?Q?Z3Bbzdwc2Y6ULBE/2aRmpEZguARvyZ+/uaJTpI/bC9PYFeM/5WcdcXq8ETU4C6?=
 =?koi8-r?Q?0MGrfzSQrtdIIYgErccdHKdVpxhTAec5Af76tI1X8lL0JMR712jdKvN2bkbo0F?=
 =?koi8-r?Q?FFrISKz4dnerpETXuU9nC/wj97vWEjyCUkmtcW0wkB+MuhaQAj9HtYfgTJTrjj?=
 =?koi8-r?Q?nn5WP5a+wG+AxXzEqWpl2xCkHpbmmtyCOrEWy0QfstHF98XMltkGk44YOryNxE?=
 =?koi8-r?Q?mhqot71IrqRG9XaYi0kV/BenzbZZcoRuDuB4AiGX5vKu7Mi/eQHjPLYerbUXsB?=
 =?koi8-r?Q?kfvG+0W0AlByHNZtqzLwzdCKZ74yw1pU6RM5tiTpWbf2yNAGsFUUEf0oLvDd+1?=
 =?koi8-r?Q?Et6T6nIzkDkl0NTC79/08mhn2wnXVGSTgv9P4RuaQLhmXJDdMbMIopiK2ldB2O?=
 =?koi8-r?Q?A+1hk/N2+LzlAVAMIv7jv5NhhQqEpX8GDaV99RTCxQPa0Opy9Fh5rTGRw3QmgT?=
 =?koi8-r?Q?sE+xfiEsquXknVFVTlzGhJjCuosPHW5MOokDMfj5OiWc9RbWOy6an0YeVesbxB?=
 =?koi8-r?Q?K1MnxP1mSu8vkq1J8w11uKRCIpdnRHdJuX0wapXhK3YE4rAvREnmkWMMcQVhg+?=
 =?koi8-r?Q?u/F+RiGh1v7QwCb8gKI6o8o1D0BrJhtzS9Ppg8eOFNaCHfihK1vgu8G5y/RbiT?=
 =?koi8-r?Q?fGgg5vTGxyk7c0ErznySJmQNaMQ4TmFStVn8eaxdRjHZIr1a28Rm6KkXA0S7lY?=
 =?koi8-r?Q?p5KzJikOIZ/Ho3erm/Og3nDDqH184RDGA1P5kR4OxsxqsEsiS3o0+3Z2x0cTzz?=
 =?koi8-r?Q?GWgsl3U9bSVxYyU/GOvq9GZUQFppPIBZgDt3qJlL/zpC+uamfx7Sz8XiY5uxxP?=
 =?koi8-r?Q?x2y3Az4gS8sPKocGUEJhcBh0GNYyd2HTDcr23KGTUE1hsA4FF42Mjw+LGhicNu?=
 =?koi8-r?Q?pjh7c7cpwg0I47dENg0rjy3pW3UV3O8vaZyeIqHEW674zWYYMOXFqznTGFTlu4?=
 =?koi8-r?Q?UjVVXsy+FMviUjz90R8BdJQGLjpB9hFkAeiHh5ohrVHtGMBwj6eKhsFy5cj99A?=
 =?koi8-r?Q?6OpxSxMaC6dO2abP72p9NVe2k1BbxGCc2khdBPwb7xdS8niTqvujOVDhJjnP5V?=
 =?koi8-r?Q?R/YF56GTQY9PWfJqwsz9LkNQZs/Ah7NM2KeCaHgNkhr8fYyKdpWYE+R2PsIrcI?=
 =?koi8-r?Q?rlpWTe3kedmBsyjtjGiNs2pJHq3SpeTTfW4drOkDfcY1KCTocEEg0i/6/odgJR?=
 =?koi8-r?Q?/AiXNdhRn2tovDlcJb4mg=3D=3D?=
X-Microsoft-Antispam-Message-Info: U6A51EVv7f42fxZuhcX4tjffhRq9rcsdSdZC5lltafAB3GsMgyC30/GGoCSlZg2un80Td/EjoTzU0J5SN7/keJsE52pP9bqe3sklqhKTZ9ObzTXjJzIznVl1vz9PgYCqUyWNDXOU4iSkIUnkg0EA1oK2rtmhdfks7rMxfDNvL/5OpYU/veGrS6AeuDzs3Wz71O6UPC6XEUQ82F/Ala+MVEFo/KRCdq9NT/qXb5SFVRsKHSJY0SjkZdL6yjDuWPimPUFF8934CDenfHxDjEO73GmO098+bcTnXEzLUT/a+2W8h3K6bkCdrwkCi+o1p6NR1JVJ5hvybcnr+PLzDydgCw==
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;6:CYHo34UgPzv80Wd7fXnFtwGNm7+0bBOrv4BspPQPJORNQd44T6wzzOR7xiW6ARE1S3YozITBeB9HsmynWYmtzQprJzGf0h7/xBkQBG3/wDV7Nz/XceGH45loobLrKK/X4iEEMPwdVi/XWh2HAafBq2amfUMhZyJgMk18rP6gkkz0n0QwGSd989ytDAh0KpOhANpJbtIE81iJ5E9t6iEDbDqDJgWIcZ5Vf/hX/UelfMzn5VO8UtZBJJfUgextiG8f6zatH/9L2vJ8tg1daxMzVoDS6hKhxZiJG55mu8Xd8nwvx6AU0VBGuYXMJwSkGQCY6PUL6acxwrMCtZPaUMF5Gwbaz2+wFZYJkHpn/bypZfGBxD11gUMbXwBzFCPdsaic+2xhv7afbRkLNVRjQcFhrRXi9MA7Ch38aRscDFOtciUICqZJ3hrwZgQTDtqG1ihDWACfJPSzRRaZSLltwpqAgQ==;5:6muVgZjewY46MZ+dceChxeScZFomVr7nhXJ5dcRuJmvxZfYPyS1pK1g3WAamCsk113V0ynx9KYSnaoBy6EwPbyRRuZpAE+gi15E46NVn+PJ9GIOoLeLKMwNXEAcQgwHhCprTAioBFR4aXUFhDhZEUspTckxJBSqiJ6gbtnwlTqY=;24:n80rLZYl7Q8XQt6mBHAuZeKSpmb8Aq8wx5UmbDaHRVEL1PU+eoUynng4y3giHr8Tm5cSczRv0E/aEsVig4mDFfNCGNg0qP6gYVsqx1dWdDo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;7:nz58OIG2ErO5sORm1I6hDdte9RchKZZYTnaprLLnDYFcX8EVgf0bgYFwC6gdkDqRrQ42NCXDGyKi5auJQm28RoDYnpIy/2hJ2ZwC/JdNyfQ7oG46Z5zkYd5Z/URyamJxsizPIzCUZBJajDMprLimmiIQrQM5fXAmyo8tHaYWrqMYh4hA09RNC9uMjgeckiQXr0aaoc9YCmyLhlaj9kMWUqDN5z6hFCg73KCMpirCPCSCmKpPzV6bT6c1OPMOwBTY;20:BjEwswD6K40o9Y4cFFUtwMhoCe3wr4K4YtXWNA2ypSMxC+Uomoefw5nL2K4agUr8Jf9nFr4a25d+uPB7BsDKnGxQaITa4om7WNEaMgyx+JEISvMN/vPM0qqEJg9+C76vEd3CRJayW5a2W1vetfF07HoclvoK5tLD3+641hyQOXk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 20:25:31.0737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb26c1e-57e3-498c-2b6a-08d5d622cf0c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 07:00:07AM -0400, Jeff Layton wrote:
> On Fri, 2018-06-08 at 17:27 +0300, Konstantin Khorenko wrote:
> > Currently if we face a lock taken by a process invisible in the current
> > pidns we skip the lock completely, but this
> > 
> > 1) makes the output not that nice
> >     (root@vz7)/: cat /proc/${PID_A2}/fdinfo/3
> >     pos:    4
> >     flags:  02100002
> >     mnt_id: 257
> >     lock:   (root@vz7)/:
> > 
> > 2) makes it more difficult to debug issues with leaked flocks
> >    if you get error on lock, but don't see any locks in /proc/$id/fdinfo/$file
> > 
> > Let's show information about such locks again as previously, but
> > show zero in the owner pid field.
> > 
> > After the patch:
> > ===============
> > (root@vz7)/:cat /proc/${PID_A2}/fdinfo/3
> > pos:    4
> > flags:  02100002
> > mnt_id: 295
> > lock:   1: FLOCK  ADVISORY  WRITE 0 b6:f8a61:529946 0 EOF
> > 
> > Fixes: 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific l_pid for remote locks")
> > Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> > ---
> >  fs/locks.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/locks.c b/fs/locks.c
> > index bfee5b7f2862..e533623e2e99 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -2633,12 +2633,10 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
> >  
> >  	fl_pid = locks_translate_pid(fl, proc_pidns);
> >  	/*
> > -	 * If there isn't a fl_pid don't display who is waiting on
> > -	 * the lock if we are called from locks_show, or if we are
> > -	 * called from __show_fd_info - skip lock entirely
> > +	 * If lock owner is dead (and pid is freed) or not visible in current
> > +	 * pidns, zero is shown as a pid value. Check lock info from
> > +	 * init_pid_ns to get saved lock pid value.
> >  	 */
> > -	if (fl_pid == 0)
> > -		return;
> >  
> >  	if (fl->fl_file != NULL)
> >  		inode = locks_inode(fl->fl_file);
> 
> (cc'ing Nickolay)
> 
> As Andrey points out, this behavior was originally added in commit
> d67fd44f697d to address performance issues when there are a lot of locks
> held by tasks in other namespaces.
> 
> Will allowing this code to show these again cause a problem there?

No, it will not. The content of /proc/locks is still filtered. As for
fdinfo, it shows locks for one file descriptor, there will not be a lot of
locks. And fdinfo was designed to show all locks for a file descriptor,
it doesn't matter in what pidns they were taken.

Thanks,
Andrei

> -- 
> Jeff Layton <jlayton@kernel.org>
