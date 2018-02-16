Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbeBPEyH convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 23:54:07 -0500
Received: from mout.gmx.net ([212.227.15.18]:54171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752450AbeBPEyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 23:54:03 -0500
Message-ID: <1518756810.17014.32.camel@gmx.de>
Subject: Re: [RFC 1/2] sched: reduce migration cost between faster caches
 for idle_balance
From: Mike Galbraith <efault@gmx.de>
To: Rohit Jain <rohit.k.jain@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, joelaf@google.com,
        jbacik@fb.com, riel@redhat.com, juri.lelli@redhat.com,
        dhaval.giani@oracle.com
Date: Fri, 16 Feb 2018 05:53:30 +0100
In-Reply-To: <7e6ee88e-8462-b1ab-a7bf-536a2c576c7d@oracle.com>
References: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
         <1518128395-14606-2-git-send-email-rohit.k.jain@oracle.com>
         <1518147735.24350.26.camel@gmx.de>
         <e773350b-dd8c-ab1a-5dae-8f62cea225de@oracle.com>
         <1518244651.10229.66.camel@gmx.de>
         <dd972024-b3d6-fa53-7cc5-9e71a01c1837@oracle.com>
         <7e6ee88e-8462-b1ab-a7bf-536a2c576c7d@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:y7QD7noXJTXotfE7abVbsAtXeBaIQCSjgib67uZYAgkO59Gr5kw
 t+0PKuiEYMPP5b/fW2UMoxvI3NzHIjz6fMBS6jsYir+FvCKLtlng7RsGVipEp2ggJRXa/DO
 iEPq0u1n//lrV/nIRuku0Q/1g5bjxKr/PJ7DvKHJV+d+Qy/a57FSVFcRXMVgIu583hP9S7c
 8/dWNipUA/b9SQV4SzQ3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q+EmTfnmgaM=:2g5H2n6aG9pGSIzvYtJht8
 W/1pkcvdNE55MuN9k5hlrEmgSFKSo3fh9biNqrVhz7d8yDxVSVIbUG6gsUazj+jSVRaW3NVq1
 js4iHLpBuPJKVv1lMP+SmQK7pKjoluhdU7wVQoVTzYYOFt8RgKWySpMq3MH0V6V73ICXVrwfM
 dnetJovjlaGoGX+/W5cxAIXSF6I1KqOIFyfd+UGaEl9Zl18D3h97dffjjCIP2GnK+TRl92e6m
 7XsBqPQRpCPSJH8mHEN9QtfFOSqv2rDbIyuhJAfiz/1K78fxHi2OZ7mEEPFEqkj7bLw2cNC/A
 YXLHF6va871PfDffgh58v0Q2zhviMB68xcLKjKoW3ZGzBWH+XRGz+UitXllydDnxSDb5CWxjc
 fvan5hGGj6RXJ1AvzsCnyV7Wj0NXn/xkggffaGyGoJIzY6R4BDUTF/xgDfMgLAB5INb7ONp+z
 4RvC03YkkMDIiKT7fVztxFP++aHu2QbQiwbe+MyPOlzWcLq82bspQ9aGcKw/cMtJTiRQsIpyW
 oGyjSksgX/0GjO+f4p1SdgTUvhXt3wPHVV4e8Iz95Q+DktNb9BMNI7cGZf+S0CVv+scWMPiDI
 FeWtZnmDvsL+JrAlS7hJZuVs3dD4DDSm1rkiXhwaUzi/gISqaESZ8M9y9uTvfersSSIHETBz3
 9qdUatVkdUSdhy2KF7J7pWTgcOrVm1BPg7nYKFphefXtNgfUF8AOVxpa21Rvj9RXW84XrKy+i
 IvU5BXwLUGqtYbV0HwWYfKPj+4i3XorL275h+FDdhafS/XR5k0XQC6MW7TT/+QMKAJrApFA4d
 Q0PfXfLeBmhNmrqOHuMvnUmbEzvqmmWg0j7Jnb4LfFuMEvv/2c=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-15 at 10:07 -0800, Rohit Jain wrote:
> 
> > Rohit is running more tests with a patch that deletes
> > sysctl_sched_migration_cost from idle_balance, and for his patch but
> > with the 5000 usec mistake corrected back to 500 usec.  So far both
> > give improvements over the baseline, but for different cases, so we
> > need to try more workloads before we draw any conclusions.
> >
> > Rohit, can you share your data so far?
> 
> Results:
> 
> In the following results, "Domain based" approach is as mentioned in the
> RFC sent out with the values fixed (As pointed out by Mike). "No check" is
> the patch where I just remove the check against sysctl_sched_migration_cost
> 
> 1) Hackbench results on 2 socket, 44 core and 88 threads Intel x86 machine
> (lower is better):
> 
> +--------------+-----------------+--------------------------+-------------------------+
> |              | Without Patch   |Domain Based              |No Check                 |
> +------+-------+--------+--------+-----------------+--------+----------------+--------+
> |Loops | Groups|Average |%Std Dev|Average          |%Std Dev|Average         |%Std Dev|
> +------+-------+--------+--------+-----------------+--------+----------------+--------+
> |100000| 4     |9.701   |0.78    |7.971  (+17.84%) | 1.34   |8.919  (+8.07%) |1.07    |
> |100000| 8     |17.186  |0.77    |16.712 (+2.76%)  | 0.87   |17.043 (+0.83%) |0.83    |
> |100000| 16    |30.378  |0.55    |29.780 (+1.97%)  | 0.38   |29.565 (+2.67%) |0.29    |
> |100000| 32    |54.712  |0.54    |53.001 (+3.13%)  | 0.19   |52.158 (+4.67%) |0.22    |
> +------+-------+--------+--------+-----------------+--------+----------------+--------+

previous numbers.

+-------+----+-------+-------------------+--------------------------+
|       |    |       | Without patch     |With patch                |
+-------+----+-------+---------+---------+----------------+---------+
|Loops  |FD  |Groups | Average |%Std Dev |Average         |%Std Dev |
+-------+----+-------+---------+---------+----------------+---------+
|100000 |40  |4      | 9.701   |0.78     |9.623  (+0.81%) |3.67     |
|100000 |40  |8      | 17.186  |0.77     |17.068 (+0.68%) |1.89     |
|100000 |40  |16     | 30.378  |0.55     |30.072 (+1.52%) |0.46     |
|100000 |40  |32     | 54.712  |0.54     |53.588 (+2.28%) |0.21     |
+-------+----+-------+---------+---------+----------------+---------+

My take on this (not that you have to sell it to me, you don't) when I
squint at these together is submit the one-liner, and take the rest
back to the drawing board.  You've got nothing but high std dev numbers
in (imo) way too finicky/unrealistic hackbench to sell these not so
pretty patches.

I bet you can easily sell that one-liner, because that removes an old
wart (me stealing migration_cost in the first place), instead of making
wart a whole lot harder to intentionally not notice.

	-Mike
