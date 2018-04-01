Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751005AbeDAGVn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 02:21:43 -0400
Received: from mail-eopbgr50120.outbound.protection.outlook.com ([40.107.5.120]:28416
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750827AbeDAGVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 02:21:40 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com;
Date: Sat, 31 Mar 2018 23:21:18 -0700
From: Andrei Vagin <avagin@virtuozzo.com>
To: Ian Kent <raven@themaw.net>
Cc: Andrei Vagin <avagin@openvz.org>, autofs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] autofs4: use wake_up() instead of wake_up_interruptible
Message-ID: <20180401062117.GA27067@outlook.office365.com>
References: <20180331022839.21277-1-avagin@openvz.org>
 <ebdc431d-cea8-378c-aae5-3b7441bb93c0@themaw.net>
 <8d578e49-c1a0-a38d-3b91-f0a07de0089b@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <8d578e49-c1a0-a38d-3b91-f0a07de0089b@themaw.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [73.140.212.29]
X-ClientProxiedBy: CY4PR01CA0003.prod.exchangelabs.com (2603:10b6:903:1f::13)
 To HE1PR08MB0748.eurprd08.prod.outlook.com (2a01:111:e400:59b1::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c0773dd-9e61-4509-af2a-08d59798d223
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR08MB0748;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB0748;3:OthrxOhBKir4iqI79nNYmPTUcSQliSKDXD/4P0WE2v340ToifgHzjwfy32HLPkWOYbd1OjKBr84HhtSMsmB+OVdhY03XczY8SOHAbxMFfjJRQY0DUi1l8bcJLCx7OUtgdDVnVNxMyTyf9EBbXDCd8sM/GqS5WyyG1K6gyB2Nxanju0S+j1brTVhWjxPjZjkTXSF4pasKrG97FCKPX//gJuMwjTWz33YUph3ZqRiDK9DG8cS8JcpGzIxsvV4QTY+U;25:smd99K8gYWvQlVCW2kCgLj4JvKudvsZfS92hEBmKHCaeyCz1yxiKNA1th9w8pYlyRz/9dNjgEnPgvhgtD1hnycAwg9klPWvbw4zPdN980zjG1qD33two+q8fW7wnpXHhiJ3dc6oJ6kVoaVtHIT8i6gLnYQr9CuMfRpFPzNXgcOI74mSYUqd9dXp73qgj8L/V7zYGaheNqcabUb/H80ZOsKuRpWGY6WywjttkE2t2w7w+gc3ZU6buSm/5FA/SOFiPJIJhDhGhmtxr5lGezsEKW3FnRbFD48iHENLOdu1lx+/yfaQs9DbdcPNkU72RPjLp0YbKY7HrH3cMJaB6Bi5q4A==;31:9JbCkWpRQs1dZtL7V5dkHZ92yUSLDDlBTYZid8HNDtaflF6MtdvbEnitJZs3MQ/n5h6xQ/voYmihrmvmT6nVLwOpgX3ed9B6ibTAgTVNTlgIMypdmaNM3iN5AYmd15KyrRTbFfSUiQJ1tdGhXRXDEMdiSMV1KvqyPvjAlDjd4A/nSPfi6ylaJkk4K0xk0pm2YJpNSlo/dzdQsFpTW89Oo4V2DJxSLDxF/KRLvF+YMpM=
X-MS-TrafficTypeDiagnostic: HE1PR08MB0748:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB0748;20:Aq1vzORZK4naupCLIz3C8+HNsJHwO3tFo8MDu9nYw80e51Sx9dxf8hdigbK+gSPU2yO6YTMGZSUHmHsjj9C6j+5J8ukZCmr8mtLALpA6RfFe5YtHlz+VUdqfM1q+LrsO3U0EZMbzSzVeptp1tWY7ZQdHiIhRlpRpTq0kjnvbw46ixs56liLIbtmzQRck+imI+uGVotZiikrejdFasyr50HeDA8OyagkaewCcxdfgUssx9NpsH0HbIwUDDV18TvUPjvstK5nnNsSEu7oz0LgFpS+ubzVSBTUjF1EjABujCFgGtYduSxfkDGWnspn6RKCtdtVl2o2VZAIv0AZWUYnhvOZxfyIqq7BtNMTsqlX116mSXNHdCwm8EHl4MOEdnDmCGjGY0Xe+/KEOYI05UAC6sKESdHVjvrK1axkbNieN2wDlNdivrB+UI3TNbNnmK4SJauuq/9b8fGxdqDBNm5JdzeQsFCKiDVO5Ll1sRgKSHLmU+S1OjOfVMAxBrfoCGCyB;4:1nuTuNUbbcFAgT6hYEPmwTxr+9eePUsj6dMFkh/LAx74kiM6PHT/b0kqQpH//7c1T/r07FuFlNU4QW2UmxqVKN+DwJ96cYo2Fr7rAbUlW9/aeGq3obj5NXRS1vp1izxc84w3XwgBGOZzih48pzcjf5W678zInUKXr/sGOQTc8Fi7WWUGFF2NzH27bH4zu+DlHlgUSaxrNlSljihsL1bwKN+zTyNN9e8da77SLK7jyIhrm4Ix7TNCLhOHifD4Ut17tjiP5EIifIs2ZdUYYpbeu3wd/KRpq1gVK7jPnnHq5pXTHzDxTqKAfk4WZjdFhE6+5hX4MK/GKacmqV9lfeByOv36TuOuCv16u6nS3ayVXO+NY8jIj57FZMfd/zW7P44/
X-Microsoft-Antispam-PRVS: <HE1PR08MB0748F844476CB9747291E2A1CFA70@HE1PR08MB0748.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171)(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR08MB0748;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB0748;
X-Forefront-PRVS: 06290ECA9D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39380400002)(39840400004)(376002)(366004)(189003)(199004)(76176011)(97736004)(478600001)(6506007)(106356001)(3846002)(69596002)(45080400002)(81156014)(23686003)(6116002)(8676002)(6246003)(25786009)(47776003)(966005)(81166006)(59450400001)(446003)(1076002)(956004)(486005)(476003)(386003)(68736007)(4326008)(11346002)(53546011)(33656002)(486005)(26005)(6916009)(55016002)(53936002)(6306002)(8936002)(229853002)(105586002)(8666007)(9686003)(16586007)(53416004)(316002)(54906003)(50466002)(58126008)(6666003)(575784001)(86362001)(7696005)(305945005)(52116002)(7736002)(16526019)(66066001)(2906002)(5660300001)(52396003)(186003)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB0748;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;HE1PR08MB0748;23:xMNn4oZiRwaQlhihdi/qvYOxIndeLw3ercga+TKCEzI?=
 =?koi8-r?Q?2VxgZASimeJVetntEzqg0+n7DfathPHglqYJ+3WVNU71JYaN63TiXhpMcPoiel?=
 =?koi8-r?Q?sWbPRwiPQ29WvE24TYL/c+UMIzOfM272aHXsHR0VazNYPPCutUDGMLflNKN0x4?=
 =?koi8-r?Q?cWN8JkQTPBQ/4TpoFczOxil6t2SkY/CCmL91GjR2rCaeQC/U7SLjjNfOmPNzLl?=
 =?koi8-r?Q?X7kw8ANwMr4ZHe43NmeUSITdu4G4SxhggdJr+lxJzsJjNUKdmlAXdv+2CLnLXd?=
 =?koi8-r?Q?QiulIOv4YyoLnVNzicQObZln4yA+dmTvNbb753W+wy6iDIQf2BjjA+OiU/aD4O?=
 =?koi8-r?Q?viNhmrQKbWPHRvuxR3m0rGWqYghmQ5IjwQ/0m9y+8mQdPTkPmzibCOJnvWqDZf?=
 =?koi8-r?Q?6Hd+6UPzO0/gXLAPZlRzRmZTAn0ZP+U9mTCBtc0zkQqaTUtroJgaVw+i4siAh+?=
 =?koi8-r?Q?TSlgWXJis/VmEvjH3+I4790xpxejuLdwkmuMXFx5nfnlT3dBwf46xpR+kZSL+v?=
 =?koi8-r?Q?Z2GlpwPrcaCPri6ICi4J/qY/1CGNFfwvdLMtuP18Cu18W88OmP/PfNV8y+leoT?=
 =?koi8-r?Q?gFo/vmmr4LQH9lM/jJXD2zElfBlqPSyHtwMGFCcx7MHOe7UNcYqtDNo6U2RWTf?=
 =?koi8-r?Q?7lkmE2V1m0b+43TQ28N/boC+HK9H759tb2AYdQ3Fx7fuFJQ584kcJQFbYFH9pb?=
 =?koi8-r?Q?Vkr8wrhKZ8o19zzhTc6pce1i21EoRzg7jyr9rptUn9t/NC1vWtajz7Gf1v7RNG?=
 =?koi8-r?Q?I1e6nU/TFhj20FkXqFoKxYF28LIJcOz9NCwoCIDzytjbK4p+fTuFajlqntPAK2?=
 =?koi8-r?Q?Rf9T1IlQFEaAr93uY95QnmQoYhO2mV0LHsZSAMSXOm5Yg8kOKBGhYVU79VxFWY?=
 =?koi8-r?Q?EvHB6JNGsHVe8FZupRMhI24IPGm+R42zoYiu5a/eupIpoc1ryftDdzlPjRYk4B?=
 =?koi8-r?Q?sCLoUye8y2DIEuq0Hucgy4+pF66S5qN8V1Onr0u8fkfv5QppNg5s/xsGH9y6KW?=
 =?koi8-r?Q?ir899cSknUMi1EKf1P3DQTI6nw0VA7BAEfHLMi0y2IcTtdnV1r3sA4S2dRNL7r?=
 =?koi8-r?Q?0iNdl/fjuHcLdUL/kc4MjAm1aH5TiwYGkatCVWVtvcQ8+ejUmm4klKlJFx91Zh?=
 =?koi8-r?Q?T6lw3xZk/cQJwtvfh1me4Gg1SjEhzvXHXVhhHA6R3WnpHAaENqHTyZZbGqy6FV?=
 =?koi8-r?Q?OEnrhBf1Drqb5++x6vzpazbDfmX7g+YryYjV4W9cyrAXOj4bwl5iRFbS9CtJjo?=
 =?koi8-r?Q?QX0K8n286S6IVISL3WhFFDq2xlOWPSdFjFZNiKu4OlgsT7P3hMOiPsTZjTEOgD?=
 =?koi8-r?Q?nci1VU1CjsHn458wFbyJaB5h6gTXsF/7PIG6y7b+5SNhj0XanAo6ChDdm5ZcZC?=
 =?koi8-r?Q?/kE64PnsKGXKeXlQYZCK0kDJaprFezlI8oJ464HzW4HlsjlZvcxz77m0xjYRhW?=
 =?koi8-r?Q?1kPNRsH5Z3fVRxsdJy0r9kpA0KShre5t0QkBM1Zfz32zoY=3D?=
X-Microsoft-Antispam-Message-Info: wA5igUU7rKe8YThsluob014v2qhAcYnkgjjCaicOzgOO0u+xafO2OsCJSQLnjMEblJJ4mFPNJusiOYHL1NLYlt5ZlSGPlLvnllazo5WjC7VhiaHzK7XdcJFrx0bJgeGmoknLGub9Z53LYG8AzO1k3erC9+peztv58xCs+TKCjyzFulz4e3ylIYDb6ObIhTl3
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB0748;6:K5vsqsj5fryyMbjMm1q+FGGBQFnopuTCaKlevDewcKSDJhQnmbpaYjzxkeu6GmjyNXtW+lZzLd0zORAh3owBaKcjRJrZ12OQijkwt9Eqtl2zI3RGbtmf4HtoezCTQgdb3BMiGUneGXznPEk2yUIm8aW6dog70ZLstXtOw0jPicNtq/rT1S4tYp0MLnQ+8739Xe+KZQvQkhiOBVtUkOXNQ9InRp0FIzLLFV/tTp0/Yv9e0I7g8q4/kT77muR8L0WtdSPEIKTG2ryx86jplG67PFJo7vqAcD5DlACuxX4NL/4OzDMzsasjdEL3VcIoCbeD96c/Z3eqCK6IZTHCmDn2nWrMtfvdKwZlck7qXdlBVrzRMbU7qdswsbmrbuk6JgBaQPTwzBWh9rVZQ0F8C8cjtLoB/mSLkmM0efgk0Q7XIp7HYLsEbPE4x5SdCPT/XTy/LhrW2mbWUf15rrDudGgv+w==;5:fl8XWl5qQOoQh5Z4vG74AB5NK3wc4j8LGfuq2HAbnBO6X0D8B5LoUZToj3oqPiIgQnloRUzNaeSgF+b01PePXrmaPme+hNOY2SHy5RefC1xPbpmF/vkVKTPzjxZWJ8rI0R6//rB5GrqE8u/MQwi4X0+bkQiwALwUPihLORcPUWk=;24:hoDQd/h9IoEgMTc9ouwco5X89YkOoPDCmscE/p9QIltmHtbRxMnLXbINVYjdVRuebpN9oWQudpNgSe0K01NsqiVfcGHhV2Q3xZSSkt9i2Pc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB0748;7:WywZe4t5Ar7ZvwsNA0e4qrwqK6Slm7E7cwKwLDCISefsFjlYtg3Y6gmSr9U9d8rNqf6yrNsxI/who1skJJ2Hp/Q1yHj9H71Q1BsuE2FfaxWFp+WocVNUToiTlsMdzQUdDmQd97VUb8aRTvxOA1CTQ37InDOMJBRKZG9NicBf+pICD4KysFGoX6/F6HKqniVWfAqEpzrtBL0OaSeWydvGZGSMTV/w2aMPPgqhghvyqnrjOiBqfV/o78lcEzOAJ203;20:7BxFWWtbOcsbVNiPeNBKbJ2SsXXeAjYbTC4XnOZNlFq5A/oF2rB0ZmrbcTfrQo+f3QCM5FK85CDfQicfcPxmJO021pq3azW7pPuUxYsaDSw6AU29iN1VkG0aFi3aEGwf4p9nYZ1ThKccpW/VszBrTxBGIP3K7Q2I7SsT9To4CUo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2018 06:21:33.9638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0773dd-9e61-4509-af2a-08d59798d223
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB0748
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 01, 2018 at 10:01:41AM +0800, Ian Kent wrote:
> On 01/04/18 09:31, Ian Kent wrote:
> > On 31/03/18 10:28, Andrei Vagin wrote:
> >> In "autofs4: use wait_event_killable",  wait_event_interruptible() was
> >> replaced by wait_event_killable(), but in this case we have to use
> >> wake_up() instead of wake_up_interruptible().
> > 
> > Why do you believe wake_up() is needed rather than wake_up_interruptible()?
> > 
> > Now that I'm thinking about the wake up I'm wondering if this is in fact
> > what's needed. Rather, I think maybe wake_up_all() is probably the only
> > one that will actually do what's needed.
> 
> Ok, so that 1 is the number of exclusive waiters.
> So what is the difference between the two wake_up calls in this case?

In CRIU, we have the autofs test:
https://github.com/checkpoint-restore/criu/blob/master/test/zdtm/static/autofs.c

We run CRIU tests on the linux-next kernels and a few days ago this test
started to fail, actually it hangs up.

I found that wake_up_interruptible() doesn't wake up a thread, which is
waiting.

try_to_wake_up() has the argument "state", it is the mask of task states
that can be woken.

For wake_up_interruptible(), state is TASK_INTERRUPTIBLE.
For wake_up(). state is TASK_NORMAL (TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE)

If we use wait_event_killable(), the task sleeps in the TASK_KILLABLE
state, so wake_up_interruptible() isn't suitable in this case.

#define TASK_KILLABLE                   (TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)

I checked that our test passes with this patch. I mean that we had a
real problem and we checked that it is fixed by this patch.

Thanks,
Andrei

> 
> > 
> > There's an individual wait queue for each mount, there can be multiple
> > waiters for a mount, they all should be woken up when the daemon signals
> > mount completion.
> > 
> >>
> >> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> >> Cc: Ian Kent <raven@themaw.net>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> >> Signed-off-by: Andrei Vagin <avagin@openvz.org>
> >> ---
> >>  fs/autofs4/waitq.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> >> index c160e9b3aa0f..be9c3dc048ab 100644
> >> --- a/fs/autofs4/waitq.c
> >> +++ b/fs/autofs4/waitq.c
> >> @@ -549,7 +549,7 @@ int autofs4_wait_release(struct autofs_sb_info *sbi, autofs_wqt_t wait_queue_tok
> >>  	kfree(wq->name.name);
> >>  	wq->name.name = NULL;	/* Do not wait on this queue */
> >>  	wq->status = status;
> >> -	wake_up_interruptible(&wq->queue);
> >> +	wake_up(&wq->queue);
> >>  	if (!--wq->wait_ctr)
> >>  		kfree(wq);
> >>  	mutex_unlock(&sbi->wq_mutex);
> >>
> > 
> 
