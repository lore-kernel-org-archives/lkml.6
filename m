Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeCWRVl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:21:41 -0400
Received: from mail-by2nam03on0125.outbound.protection.outlook.com ([104.47.42.125]:51278
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751806AbeCWRVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:21:38 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joe.Korty@concurrent-rt.com;
Date: Fri, 23 Mar 2018 13:21:31 -0400
From: joe.korty@concurrent-rt.com
To: Julia Cartwright <julia@ni.com>
Cc: <bigeasy@linutronix.de>, <mingo@redhat.com>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <linux-rt-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RT] Defer migrate_enable migration while task state !=
 TASK_RUNNING
Message-ID: <20180323172131.GA2670@zipoli.concurrent-rt.com>
Reply-To: "Joe Korty" <joe.korty@concurrent-rt.com>
References: <20180323150959.GA16131@zipoli.concurrent-rt.com>
 <20180323165921.GG10942@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323165921.GG10942@jcartwri.amer.corp.natinst.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Originating-IP: [12.220.59.2]
X-ClientProxiedBy: SN4PR0501CA0106.namprd05.prod.outlook.com
 (2603:10b6:803:42::23) To DM6PR11MB2570.namprd11.prod.outlook.com
 (2603:10b6:5:c6::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d10d0742-4dab-452f-d62f-08d590e287b7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR11MB2570;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2570;3:m6KwVIkdLsl85VFr9x5egQu2SIQjeSJBkYmInlKB8M5nwiiONBSiEdfKvzgYtJ8dbhkqc1Vj86oNPpP0rnxmwF6bzKhpjv09tpROZl57XdIePukArQ/x+47sk/O+NIMK99Lv8BQgEZfgAmxUEuaYNMhS5HKyqRiKad3jChA7mHxnhRXXF6YYLUURLZViKSkCCOIuLOdv5kRQztwkQwLGLPnZ5savJHGbnrF8z3UcnmikxGnVLDpT32m2/YYXqNga;25:RG4uYJwb82KlEhOp1Vx6xFdld7RiT2eHxO7GXm0W+nUH8PiUZFPnfDaZs94NXV0BGz6WGDPxYlPkNUspmfwGE3ehe2WyKsMSOIXg1xCgUQPPRhEUnIms2Ouio88P6pcvlvZmjJLi89fxlFppzxF6usR1PKBOwOAzGJRfU8fSsr6QrhOPJqtHbW+QhMhpSN/sVlZHacRLJTX5FmdLz+6yVpkL9REoc9J83KGN44OqRmp3YZyP4u65hdm/GgfehmytfczY4Mr8VhTWc5qslBFv7w6Gnr8FivHmSspZYZb3KgWcI0N3TF8apF3O5augIa069HQZiTSSnwFxb4fmp3YFwQ==;31:pGGCjrSRoflXXT8rMW+TSORR95h0fhpOOgg4uvzdMY+LpMwsf4tJKZrBj8IpqaDalx6uQ3fEFtKLUjYrchYzNTFiaPpbD/Xgoexyc6xg7fPluEtIOppcS+CHl9AcFrJ3DkoBjUV9vzhweJMdkO73B0HeSh6d6pVnGl2cvetNoSTdShkTyU5wafSlsMxJEpFUiQp1izbao9ZYmTRmhuZVDSs8cSJqxGIopImBCkwcK+w=
X-MS-TrafficTypeDiagnostic: DM6PR11MB2570:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2570;20:em88itURNdXDxFbqjhTZfqFhDBlzCT7vVZEWoDo/HvW7h2+/qJkqWI2ofeNvzI/qOe4EZAaCdk9LtjqzEOAmzm9Oay/24wTLBiLkOqjrUb/r3X30jiRuyWcuo86VSn+D3duEzPhSUW/4ohB3iKjrsI02DsBTc+gAejKIJZfOtQYfDKT+qd7oZvQL6g/u4IQenYw23ctYHlj7UJ148p5J8HIelXFqatXtJNcG1sB9FNVIsQvIUxLIX9krQ3aronZWCJUlmmHx9Na5nB+9PWsITqQJlR8Pc3hA8oMOexQZhOyccGjhid51S8XmDSbMFxSMfP+KnWwBZ3sc/g4DziBBSA==;4:DM7k//V81buQw9wp6w0uw+A7Bt3oILiGAvCb+2sk5lZL29D01AIvuFIEOJ4XDuxdE2rP84oDcYejMgIBDGXLKxiGduzRZ27B5B6TxmvP+xxwnaKkVbRfG2YGzRycl6G5Rjc2JKLudQk5bpxgLYwYkNe/nElFEot+BAIXujnK9aX0envEGD5/htax4SJC3p840XmB4MscuVuJFmnsnyv5Qj8/kVlrFtgcGpIf3IDHOBovS1y4orEfCOc+PjQlvYL9My5gNJgJPK13ipZKmtdoHA==
X-Microsoft-Antispam-PRVS: <DM6PR11MB2570C679BECC8F5329011BD1A0A80@DM6PR11MB2570.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM6PR11MB2570;BCL:0;PCL:0;RULEID:;SRVR:DM6PR11MB2570;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(39830400003)(346002)(366004)(376002)(39380400002)(396003)(189003)(199004)(51914003)(72206003)(9686003)(58126008)(105586002)(54906003)(8936002)(16586007)(97736004)(81166006)(59450400001)(81156014)(25786009)(7696005)(52116002)(33656002)(4326008)(478600001)(76176011)(229853002)(23726003)(316002)(8676002)(53416004)(53936002)(446003)(106356001)(55016002)(3846002)(66066001)(6246003)(1076002)(69596002)(6116002)(85782001)(86362001)(5660300001)(386003)(47776003)(2906002)(43066004)(6916009)(305945005)(7736002)(68736007)(50466002)(6666003)(186003)(26005)(16526019)(11346002)(18370500001)(85772001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB2570;H:zipoli.concurrent-rt.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR11MB2570;23:Y9dGU2jvm8+VK0d3o6xWXkdAMy5CYNxGQwCof4Tb8?=
 =?us-ascii?Q?3KgOUeieJ/051dxr66bznOa7MJcUNfHaoAN3XOzh7ZIgBx+KMiIeEj7M+bfU?=
 =?us-ascii?Q?AL/VTqyGGaWVbD4Gl5r9KTEuKhnfhRZcz4dxy7p0Ml05Skj+3Yk8ULpt0pb5?=
 =?us-ascii?Q?JdC+qCGH66Sm+thZ2Kz5sLfm2X+v2C6tmSiOyUXME3Rgd1gk2A46HjsIqZOS?=
 =?us-ascii?Q?RUT9xEzC5IGoDRfwKdTCJAh5siZLqRGxHoO7zoYzQ9klFV8OhZaSq7MT9UAo?=
 =?us-ascii?Q?4NcS5m9m+rvGzgm7Exd3rWUUTO1xWImJ7tsK0rNcTwnrbi6bg3J61Bq7E31O?=
 =?us-ascii?Q?LURpXHpPY5gFpKBJ++5/Flz3kKkQ9mH9jkkKg6TVRyxjDRwrTY/Jw5uznKW7?=
 =?us-ascii?Q?UkksZu/EiKLwVyoKZjI0B0ujtj8r2dMmEOnPNQg7A65JGeK0HyjRgW8d1T1l?=
 =?us-ascii?Q?8lHslvhtwllbVhKkvGMmF9k0BisXftYyijS7tTa/lCMwv2Wr9fT8coC8ePc3?=
 =?us-ascii?Q?CdjNStXDskY2WQDBFB1vG/n1nWNAaPQ5hPsWRxxPV2WNPG2/uIy+v1r+rOO1?=
 =?us-ascii?Q?oAdWszXAexZMcJydogTASx3ilQ76GMArmHLxcNtJh4BYVNB0va1yi5QbAYIy?=
 =?us-ascii?Q?0cqnweo008myNs1YXkAINfm1q/rBIu616AkSGzohZNpu/KF2+4NEm9kM0My5?=
 =?us-ascii?Q?BspkVMlP82NylMR6bHtVSaRSaSVCEceWIbU8yZ9IjKraQFcPg4UWMdvc1vYu?=
 =?us-ascii?Q?3YuX+KWpJUTXtLgMNiYzo19m7GZhd8RGm4MaSUJLRr1MsauTdXMuVMuCL/xJ?=
 =?us-ascii?Q?Sbba1TfzXChvhIcbbEmWXz3Yq67xH1ufh6/sE5XUk4UOedg46d84HQUNsD/3?=
 =?us-ascii?Q?8AySeuqrY3oUBQdu2PAQpxVjtKn/K1C1uNaQaikYLYEu9IiRJgMs94byT7hN?=
 =?us-ascii?Q?D/Yt0hUvf/PCaEqVXTsy0h5vJEMjF1FMURNaEneHpHfRAmHeQyNARkenBihg?=
 =?us-ascii?Q?+buJsTmOv+hmC5Q/Pr7L1Y9DcaJPFG9/dEx3zhB6Wa3U18N7r+HDgPR2dXgC?=
 =?us-ascii?Q?A+HXR8sSzyFcyosekccYXJtD/tDDtkm9fIj2cEqtBtepqvTmIITJjfkn7bVg?=
 =?us-ascii?Q?2jBgfbqYxJPvCQz5FWZbOX8zUPIf9C23YFTjOq8D68C0sEIrr4xTkf+sp07/?=
 =?us-ascii?Q?kFyZ82IH/7JHfWwdQ/Es0UGEIyZq/hXUzguMcMePeD7ytvL86oeoizgrgX1r?=
 =?us-ascii?Q?CNYl+ki6u3R7zFfIBxo+0554q4nerVcx1y09mkYQfIdPd31UApl8msX7Qq1X?=
 =?us-ascii?Q?/AxR0Q6YatL55LYahjywrgdcwg0g1YUdcEwcpJ9N2jcHIwBTmVpazvQnM024?=
 =?us-ascii?Q?odN/D3X08EOT2b81gBsqwNneLN5YPGcZQEqYMKA3WoKA0IO/MCvf4ng0EUKO?=
 =?us-ascii?Q?aBms8u1KP36lwjPoMXTgvjNqXfFjVsNMDJrZy6cKemNskqkAY7I?=
X-Microsoft-Antispam-Message-Info: ZpPJEiH9ccaJ9I93ywG144TMHFOCs2JUaqIGdmbVbws5djMgfR05249Bivne+PadDX72lQW6RMkXjUKfnzbZX0XN2WtbUvBeqRfu9ThYLb1qSApOy6k2ggELsvNSAWUswlpgD+0k4RbT4p4XgSZotBNNCCVu3DQwu6ztY6S0veqZEbA6OHx85m2AGavEdY3G
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2570;6:Hw6UaY1c3eyb5P12EimXrtyfUm2Dqsn1amuskv1RKZG6X25P/jHZEtcTU7KvuNUv2tzd6ZptAulOM7GttSi25jDLwWRCNhPxwpxFzGRJnrRHmH3J5Blx7NFc6MJGiKU2gJXsWnKQ7Qh3as42/3vsuC3tNf3Et+C7uteKyfj7yyYeTb1QkRq+nZXL9KLa3Y/QYnZTHie6Yxr93aH414CzVhv2AUUKUr11+WSm+fcSL1pjVe0IGlAaqN9/mSYA2D7FPvF3RTD0HtrpMnS/eCu8EJkTmSO54ZEvssj950D8sPITi3ghu6pF7sQT8F0V4uN28tWuyh+8e1T8MvW1iLujiYoJLtQhjxPNcwXxDrXXcQg=;5:rO8C+b8HUTKPsGAPJeab21l40x0DJGZR9mxQWCYauDWy6TdtQENfmWTPKc8GzctN5NF6PxajbhqbZT432pLmegJJp3cfEMqWfHBxY+QwNRGoUDWKtQFZgmc3iO9dbd1XRz90yuRe7cN2eQqcVh/z0DzHT122JOEKn2uDfSdZRk4=;24:S1/SZa7nSNold9/DBFdwSNPRdcX2RLbm9UtSQwLxTEsWYNx2OPKrZrI2vlWZsdcdsb7js8alaFnWY+qHApEoHA9jv6kxXi0wcJBbKDL4efo=;7:rvBpZYK3aEyAKI9bbvwwiP5gbv0U935WWSYP5tBwR6y3X4EKk7IgtnxDuxmZzYpA5oFnDNJWSa3Xisj6aDfi/+IuiQBtMA6wuuy3joy473vWLzjmVOF1lQOqYaxOivCVfvrnS0LojJsUAw7xVV+halNlPLNrY1mHL8/XYanhY0qw5+ad6dsb+OJ957rVVwuq3B5KHXHWLMo1qEvC58ZotTlz5rTSrQ6Xf27VB2AUTSSGJFJHdL5vceuy/+Ca6RCW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 17:21:35.0992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d10d0742-4dab-452f-d62f-08d590e287b7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2570
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,
Thanks for the quick response!

On Fri, Mar 23, 2018 at 11:59:21AM -0500, Julia Cartwright wrote:
> Hey Joe-
> 
> Thanks for the writeup.
> 
> On Fri, Mar 23, 2018 at 11:09:59AM -0400, joe.korty@concurrent-rt.com wrote:
> > I see the below kernel splat in 4.9-rt when I run a test program that
> > continually changes the affinity of some set of running pids:
> > 
> >    do not call blocking ops when !TASK_RUNNING; state=2 set at ...
> >       ...
> >       stop_one_cpu+0x60/0x80
> >       migrate_enable+0x21f/0x3e0
> >       rt_spin_unlock+0x2f/0x40
> >       prepare_to_wait+0x5c/0x80
> >       ...
> 
> This is clearly a problem.
> 
> > The reason is that spin_unlock, write_unlock, and read_unlock call
> > migrate_enable, and since 4.4-rt, migrate_enable will sleep if it discovers
> > that a migration is in order.  But sleeping in the unlock services is not
> > expected by most kernel developers,
> 
> I don't buy this, see below:
> 
> > and where that counts most is in code sequences like the following:
> >
> >   set_current_state(TASK_UNINTERRUPIBLE);
> >   spin_unlock(&s);
> >   schedule();
> 
> The analog in mainline is CONFIG_PREEMPT and the implicit
> preempt_enable() in spin_unlock().  In this configuration, a kernel
> developer should _absolutely_ expect their task to be suspended (and
> potentially migrated), _regardless of the task state_ if there is a
> preemption event on the CPU on which this task is executing.
> 
> Similarly, on RT, there is nothing _conceptually_ wrong on RT with
> migrating on migrate_enable(), regardless of task state, if there is a
> pending migration event.

My understanding is, in standard Linux and in rt, setting
task state to anything other than TASK_RUNNING in of itself
blocks preemption.  A preemption is not really needed here
as it is expected that there is a schedule() written in that
will shortly be executed.  And if a 'involuntary schedule'
(ie, preemption) were allowed to occur between the task
state set and the schedule(), that would change the task
state back to TASK_RUNNING, which would cause the schedule
to NOP.  Thus we risk not having paused long enough here
for the condition we were waiting for to become true.

> 
> It's clear, however, that the mechanism used here is broken ...
> 
>    Julia

Thanks,
Joe
