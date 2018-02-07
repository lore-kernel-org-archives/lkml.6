Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932087AbeBGNxc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:53:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753731AbeBGNxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:53:31 -0500
Date: Wed, 7 Feb 2018 14:53:26 +0100
From: Jiri Benc <jbenc@redhat.com>
To: Christian Brauner <christian.brauner@canonical.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        netdev@vger.kernel.org, stephen@networkplumber.org,
        w.bumiller@proxmox.com, ebiederm@xmission.com,
        nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, davem@davemloft.net
Subject: Re: [PATCH net 1/1 v4] rtnetlink: require unique netns identifier
Message-ID: <20180207145326.7e4adf24@redhat.com>
In-Reply-To: <20180207133620.GA3589@gmail.com>
References: <20180207125320.9103-1-christian.brauner@ubuntu.com>
        <20180207125320.9103-2-christian.brauner@ubuntu.com>
        <942f99e9-086d-25dc-e008-8de2c5c721b1@virtuozzo.com>
        <20180207133620.GA3589@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2018 14:36:21 +0100, Christian Brauner wrote:
> On Wed, Feb 07, 2018 at 04:20:01PM +0300, Kirill Tkhai wrote:
> > Can't we write these 3 above branches more compact? Something like this:
> > 
> > 	if (!!tb[IFLA_NET_NS_FD] + !!tb[IFLA_IF_NETNSID] + !!tb[IFLA_NET_NS_PID] <= 1)
> > 		return 0;  
> 
> I always prefer for conditions to be separate and readable even if it
> means additional code. But if others feel that there's value in avoiding
> two additional conditions I'm happy to adapt the patch.

FWIW, I don't like the n x n conditions much. But Kirill's proposal
seems not to be much better. I was thinking about:

	int cnt = 0;
	if (tb[IFLA_NET_NS_FD])
		cnt++;
	if (tb[IFLA_NET_NS_PID])
		cnt++;
	if (tb[IFLA_NET_NETNSID])
		cnt++;
	if (cnt > 1) {
		...errorr...
	}

but that's not better, either. As we're unlikely to add a fourth value,
I guess I'm okay with the current approach in the patch.

> Before I added support for netns ids for additional requests Jiri made
> it so that all request that specified properties that they did not
> support returned ENOTSUPP instead of EINVAL. This just keeps things
> consistent. Users would now suddenly receive EINVAL. That's potentially
> confusing.

Yes, please, keep -EOPNOTSUPP.

> As for the case of passing multiple netns identifying properties into
> the same request EINVAL seems the perfect candidate and the error
> message seems instructive to userspace programs.

Agreed.

Acked-by: Jiri Benc <jbenc@redhat.com>

Thanks,

 Jiri
