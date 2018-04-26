Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756383AbeDZOHw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:07:52 -0400
Received: from mail-he1eur01on0118.outbound.protection.outlook.com ([104.47.0.118]:21781
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755172AbeDZOHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:07:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 0/4] exit: Make unlikely case in mm_update_next_owner()
 more scalable
To: Michal Hocko <mhocko@kernel.org>
Cc: akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        ebiederm@xmission.com, dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <20180426130700.GP17484@dhcp22.suse.cz>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <9122972b-9a5b-db65-f145-585d6076b2ed@virtuozzo.com>
Date: Thu, 26 Apr 2018 17:07:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426130700.GP17484@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR09CA0071.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::15) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:dcpvYqszH+qD9R5GVhec4QKzMIe4UYOWbe5uF0ydbbwA47zS52KgaMvpTc9DTo8YfGhSz2ze+kjmj5BVf7uSw8gtBeaJyd0MeV6j48W/SyClNO+YrG9Rq97S8JviTB8mC4vsinApUVseuMTG8JbWkyLIP+exe6tf8yT6JyFctQ4qp5iPtMrWooVYYZ42yWJse6BpEZ0DR3OQvUco86DegzBjMR3FfzH7x9DqOVXOrM2s9Za1BwvxDrMDNw/TtBK4;25:v/KiH+xh86woKXWYgYK8Wlzy/po0XE78gp0uj86HerPUQS1v+iRqUkmTjaPSvM1kBeODVb5P/Q0NQl1nWnP0d4AFQhv5zd9QW5zPIM/3T6d3otPwmzitAB9TzNA5SsLrGCyNdedtOHdC5YL0Plg7ToTcaSqIGg6hHP/sfoV5cJboqTtKrNHiJHsvVQ1xdlMztRo2sNQZadbYd+hi5ydQM+Ul/ZgZqx1YK3jVHvfBHCHxA7W/e1o8CB1JJnsjCCgvHHSb5Mwd9P8y4rBvG3lIO+oq0b1pyUsAK1TuB4JnsV6fbzplTZzyKKSnB16HeWrJvl6qU/Kjr22NSLwZhg1how==;31:XiVl2XSI33VtwtOdsgp8aeKCqwr13d4Mfqyy8+hf5fCttfTEkCjnZxAUa/x676y7z8Pr2XnFF8O2wGuAuPIUP2N3Ehw7+gjjcTiKdV3KiFFKzUd0wgsWyZIFXlaVAWW+gCT1uc5pGXtAXFsW0VH2fWFJFmVzDdLUx0KAGMgHbbGUPColbZ5yKL+GzHBSwaMMUIJ9iG5QMBhXoWe5sh1VYHSugWZBGM0NM/Rv4ISro4A=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:TjqMmJwz57v1uYJCmEm2FfzE/Y0h7N09vmOvHMH0a8b5yom7Ju4Xa72ccQJE3B3w3JvKNk1wp5gv6uPfhFWvcjzMpQD2J+bg4o/ViOjC8SjJbMbe6xtW7Mr8qSbsBBwm4tRb+6M30sPdOdibQ9mP+x+Uz50qKugx5XSLgHtkemXB+bRdoGTwmqCSkJ3MDpa+NCk3+PY/4DLPyLrl9rRglJ0n/tbX2Z2mmNQaMELxW2bUQ1ooJBS9DGzCr4aqE/Kui6ZGHxsFbFe+5BF6R7UfmGbuL4g5v8+C0Lmw0F39+eGn9Yq/NZEhpkhvrsXqNhTHP6jEuXhKlN9hoNl1jSVvslrSP2J0ry2tKMVakeo3GxWhrr6sSEShfeWERtbwKnSAAz9bXUcJKUflZyHJyhl+2aNpukO70zq0JOovlXrmki0K9Im9CzylrU7Ti1QM2vGzcgiKhstCQlKMydZLTAG4/QAG88eov5Ug5rWQoLW+UrmxnVHilM1fPWBWvnPONorc;4:xPhesHtj6PCn5vMVNlhzaVefYovDpuywLsRWJlSBmeRB38LyA1hW/jIJHvxcW4/37QgwSP1OKLCTy2ll9QA4XldYlSsK1m/YRnrkDiAk667nXxLO/ZPP4Gqz4kmi3hBd1aIdQM0KL+gNNMPGjskHeAovBOYHqu9xgC+QixpaWEL7Gmu8sYSg83nu6/d9kSW2mtQj0IZXpSx245yVtIWL+zsiLtpNgX/eeRteVl2HYnjxV90HJpezIq/2xFrOJYNVDatthSuVqC27PFKpL2CbdgbwJdkXcy4Bnqm7EpNA4m6JaMRqc+npmWaPmcTWAaqI
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13429B3032673BFDDE8A5F03CD8E0@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(346002)(376002)(39850400004)(366004)(396003)(377424004)(189003)(199004)(31696002)(2906002)(478600001)(16526019)(47776003)(68736007)(5660300001)(446003)(476003)(956004)(25786009)(66066001)(65956001)(11346002)(65806001)(486006)(230700001)(65826007)(305945005)(58126008)(316002)(386003)(7416002)(64126003)(2616005)(16576012)(186003)(106356001)(105586002)(53546011)(4326008)(55236004)(7736002)(26005)(53936002)(8936002)(97736004)(86362001)(50466002)(77096007)(31686004)(52116002)(81166006)(6116002)(8676002)(6246003)(2486003)(6666003)(59450400001)(3846002)(229853002)(76176011)(36756003)(52146003)(6916009)(81156014)(39060400002)(23676004)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6Y0FjL0NOcFJMYkMzMktialNoc0hlWU9k?=
 =?utf-8?B?M1dGOHB3SFd3VS9sNlRyL05mcDByN0hpRXFsWDlHWmVEY1ovQlJlOFhHbjUy?=
 =?utf-8?B?WUpiZnlEaFhFTXRJVHo5cWNqNHV6amg5MGZuMW1JVVpvUXFzVDNOcXUxVytp?=
 =?utf-8?B?LzBLeW5Pa1E2Mk0ycEtJeVBQWThxZENpOFU0c1Z2UEJ6V1NuRWVsQ3BkZ3lV?=
 =?utf-8?B?U0RhNG9rR0NucVhhV2YvcnNtOEpvaUJmRXBJMDNxMjZVdGhBVkwrMzZsZXZ0?=
 =?utf-8?B?VzNNM095dW92QlN4MDhvOFFqZHJzeE1rTWdUd0xHRzVhUzdCVEVhenRHOXNH?=
 =?utf-8?B?ekErbWZIVW9XNHFWeDN5Sm4zZ29KWVNLeWtBTTVEZ3NIVERpTGZ3L2JXVlRr?=
 =?utf-8?B?RTV4STFudllBQ2dBY2EzeG9FME5jYjN2M0JoRG9Ed1pCRkN4ZmdUbzc5ckVW?=
 =?utf-8?B?NklYUGZqbmZGZjBjbk9iNVRIakg2SWEvNU1nejc2M2Vib3BJdHl1Rk02b2Zi?=
 =?utf-8?B?T2drM2xMSlQ4b1grUGk3bzcwS0VoNW5VUU9ZcGtEcThMUG01TjduY05MeUpy?=
 =?utf-8?B?WXVUZmFGQzdaME5LWHYxdXlsaUVEMW80M2M4b2NsNG9BYk1BN0JjU1NGb1Nk?=
 =?utf-8?B?b0l6MmJDeWN5VzRQUnRwN0tYN2UyZWZEOER0N09VMmtqUS9RcHNWUkMrZnRt?=
 =?utf-8?B?M1VUWU1IVzhUSWRpMTlaeTc4aEMrRG9LdnQ0cHplci9vc2FQYzJzUDlRQmdI?=
 =?utf-8?B?b1VHRWJmS3FMZVRWK1V5TitobEwvM2dXR0ZlOTNLTXZFU3pQNy9aWXZQampq?=
 =?utf-8?B?N1hQb25kdDJoZGswcFNKK0tjbmlhNkNWMmZnRFBteHkxU2x3WW52SklMNytk?=
 =?utf-8?B?cEx1RWpMTEZ3Wm5naUF1UnRyY3FyZU1SbWQyU29qZVlkV0VxUUpwQWtaam15?=
 =?utf-8?B?Nk1sVC9lK3VLeE1JeGFCQjFmSWVjUExSOE5WZWlDWG5VR2doMktPd3AvVGhq?=
 =?utf-8?B?Z1lablpBUGNoeGJ6OXgzenlqVHFFV3d0ZXJsdFJEelRNMk4rcDBSSTZWOW5K?=
 =?utf-8?B?MlBZNFNuVFVtbFBUK24rNWxoK0o3c21oUWpnSjFGd0s0TVNNS0k2VnJlK3Ay?=
 =?utf-8?B?SmN5WFhzM1pnck9ueHhYckkrdm9xYWgrSGlaNG1TdHkzQldlTGk2N3pOazFT?=
 =?utf-8?B?S3BobExXMk9sNDVCdEpXWUhvWUZWbk9SL05UZUNJdEVUR3pyT3dITFN0WXRo?=
 =?utf-8?B?WkFhajJLV0o5WHhDaGNkVDJGV1dCckl1N25rTi9CaDZNa2tZYkhkcWYrWjJp?=
 =?utf-8?B?ZXFFMkszOGsxUElEOGQ0TS9CSTBkZ3c2YkxsU3JtbmxXM2tuMmtJZEFCUWRM?=
 =?utf-8?B?eG94a05UbWV3MmZCNHduYThNWU0wYVBaeGd5Mi9haE9ZK1p1c2FEVjRBMGdm?=
 =?utf-8?B?OVp3OEJzWVpuUDJFVkUyc2w1V0hWbE5CVnBrT21lOSt1WU16ejFOYXFjaFNx?=
 =?utf-8?B?emxLaERmUUZOV016UzNpeU5rQkxENzVxMTlwVDJ3OVFIUFc5S1ZVOWIyTXVK?=
 =?utf-8?B?QzlMZnlxcFVRazE2WTZPdUt4NlpkQ1RMN0RLd1lodzIxZjlkK05VT2Fsem9M?=
 =?utf-8?B?Si9ySzIva0htcWIrRllXSmZ5NjR0YTdiTTJBN1pkaHMveE1CMjB4ekRDYWQw?=
 =?utf-8?B?WStHdHFaSGtrRHRZamJaWkhTanphUm92WXZDMFB5RmZZM29icHhoVEVtWDFM?=
 =?utf-8?B?Tnl0bUJJUm9lOXk4WU9XTlV3a01INXJDbzBTc3IzNHIzMU1QdFJXY3VuT3Ri?=
 =?utf-8?B?NmhrQkkyV01mV0kwQUErNE1MNXFqdjhwQklQMWs3WWZpSitsdUpHTFB1emNY?=
 =?utf-8?B?SjhDUkNjT1lHaGh6N1VIL0wvV2dDdnFRNTFidXNqY0tJZ0JhVXJicWdhMUwr?=
 =?utf-8?B?QUtDTVV5TFhvNzJ5M09rWGh3SDN3TmJxNWpCMm5HRGdtT2FicVRJajNOcG9Y?=
 =?utf-8?B?UUxpaGVvVUUzb0l4Z1BVenlsdG5WcWxKQkVaY0VBSzJ6QkxZY2dVM293aGcv?=
 =?utf-8?Q?6WF2JG3eLNyZVCRjuzN0PZdiO9/?=
X-Microsoft-Antispam-Message-Info: kJF3tQy7SiCGI5pYNVpMkbVPUHq6HNJSePuAl9K8uo2GhgywJMXkt8moSCEyvLEUJUc8erdYqInI+fhYcdWU/2nBbXnv4bPIlYlGLULUSr3iPTM+tM41atTXXdPHhyiRZvZd3G0Onnv1wdZt/lIt4rzwooi4nzXh+qosdXKPaqdge04L2MY/7Vxz60/TDdyZ
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:JM7N4gqWj3mIdC0bSBsoNdNTUgZpMYCM0uEoAPU3lbwywP0AXQkJwcZPlxhuveLkGmh4RjaZEBHOCmLccE9pdjTksOqnn5oPL+iIo4rkpaWkwKs205bvBm7i6dpD1Ypfkf1hCrC02hzZHAA7M3hjsOu9XqsXZew/KHG0QwzMRVPeLun0bpq0aMsoI5ZDKtOG0dd5GRZ/jI5HdxY6CyqvSg0RI1NhqMnM9ppZBbtw5WjM/mJoh3rnXGPuKNhrTdjrXILN6FOCKk24V6iKRj6Vv6pPdbS0J90E4YxqrUrmqGroXRQjUX6ZtQGlmV7xgZfmbqgF/74NwS2hqpZPywg5eIhI58W7/1do4ODws8JjPsT1283OMxXKdGyT+zoAkY4AXee8zEo1JnPePEPwcHouowtRZfxvoUBDM6rgoWClGt90xpKDrPxzg8KEPM11SCC4agUE6XwJ+hzTXJYh4K6phA==;5:exCQRh4mMfaMQqyPKPOgMUuA11GYgrbQZzht0eHqGn1g5mVo44tWhMsC3UYHHfoIlTag0sX7moBfO11DQRlB0koP9JfAV9zqaKpxDWRg6GNFABB9cj3CQ4wONsH3YDhVX2LfyogSTTkfnOIPKJbbzAswWRoHvhKfh3zWGUKsmNM=;24:hdXgbyxjMCxKw7ezMu06+Lw+7iA3IIKopZ3fp7qEOqT1VeLy38kOAaIxE7qwUehyjbxhFzCnV8FbZUS/eMlfKjwTx2ikSx2UsHAWK3Qgye8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;7:EeFGeqZmR6ALItM1Sglz8FXPJTa66ugfW96fJPD/zJw83O24EF3AL9HY1XVttMOlT1GCm994UtdwQGFkKpHeCfeo1uVaPL3Z4JPs447c0kLw9qUVo/8wQlI3qUJdBv3mYZrdI+1Ej7ILW4XMo9WO17mx3zOPzabAMLysEgnRvdPwUUb8xiD9hMuADCsJeZQhVK+ZKP56ve1CwK4hSZmYJKRCDcOqiSR+ySCLAeWek5x3qcEU7H1JpHrPPKNOP8im;20:r/0fY5WfG9j4EkOkR9kmvgULDT1Ikf+raw7BjyzuO7N2h+Q+p03tDbkWpyl9C6PERjZS27L+Ab8b1a+zBWkIPQ1JoEXg/xp1PTkQQYpJvQ6gRbrZ3B6rA2iHAzd7zRjbmpnsg3KKMrN4wIz7xitAcfhtClpJngAun0sTdwZdIEM=
X-MS-Office365-Filtering-Correlation-Id: d6f3f42a-a007-44ae-6201-08d5ab7f14aa
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 14:07:42.4168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f3f42a-a007-44ae-6201-08d5ab7f14aa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.2018 16:07, Michal Hocko wrote:
> On Thu 26-04-18 14:00:19, Kirill Tkhai wrote:
>> This function searches for a new mm owner in children and siblings,
>> and then iterates over all processes in the system in unlikely case.
>> Despite the case is unlikely, its probability growths with the number
>> of processes in the system. The time, spent on iterations, also growths.
>> I regulary observe mm_update_next_owner() in crash dumps (not related
>> to this function) of the nodes with many processes (20K+), so it looks
>> like it's not so unlikely case.
> 
> Did you manage to find the pattern that forces mm_update_next_owner to
> slow paths? This really shouldn't trigger very often. If we can fallback
> easily then I suspect that we should be better off reconsidering
> mm->owner and try to come up with something more clever. I've had a
> patch to remove owner few years back. It needed some work to finish but
> maybe that would be a better than try to make non-scalable thing suck
> less.

It's not easy to find a pattern on such the big number of processes, especially
because of only the final result is visible in crash. I assume, this may
be connected with some unexpected signals received by task set in topology,
but I'm not sure. Though, even it becomes the most unlikely situation with
some small not zero probability, it still has to be optimized to minimize
unexpected situations.

We can rework this simply by adding a list of tasks to mm. Also, reuse
task_lock() of the mm owner for that. Something like:

assign_task_mm(struct mm_struct *mm, struct task_struct *task)
{
	int again;
again:
	again = 0;
	rcu_read_lock();
	task = mm->owner;
	if (!task)
		goto unlock;
	task_lock(task);
	if (mm->owner = task)
		llist_add(&task->mm_list, &mm->task_list);
	else
		again = 1;
	task_unlock(task);
unlock:
	rcu_read_unlock();
	if (again)
		goto again;
}

Kirill
