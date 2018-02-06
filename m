Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbeBFWbt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 17:31:49 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:48544 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753220AbeBFWbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 17:31:47 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@canonical.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        netdev@vger.kernel.org, stephen@networkplumber.org,
        w.bumiller@proxmox.com, jbenc@redhat.com, nicolas.dichtel@6wind.com,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net
References: <20180205155550.21432-1-christian.brauner@ubuntu.com>
        <20180205155550.21432-2-christian.brauner@ubuntu.com>
        <2eac607b-e847-1b21-b3cb-6a45130138ee@virtuozzo.com>
        <20180205232438.GA8695@gmail.com>
Date: Tue, 06 Feb 2018 16:31:29 -0600
In-Reply-To: <20180205232438.GA8695@gmail.com> (Christian Brauner's message of
        "Tue, 6 Feb 2018 00:24:39 +0100")
Message-ID: <877erphhry.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ejBm9-0007Fc-DH;;;mid=<877erphhry.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+1XEVh/rtsVB5ZCWKXj7hvWU2jPq3OP/o=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 T_XMDrugObfuBody_14 obfuscated drug references
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Christian Brauner <christian.brauner@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2449 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.1 (0.1%), b_tie_ro: 2.2 (0.1%), parse: 1.76 (0.1%),
        extract_message_metadata: 37 (1.5%), get_uri_detail_list: 9 (0.4%),
        tests_pri_-1000: 13 (0.5%), tests_pri_-950: 2.1 (0.1%), tests_pri_-900: 1.67
        (0.1%), tests_pri_-400: 65 (2.7%), check_bayes: 63 (2.6%), b_tokenize: 27
        (1.1%), b_tok_get_all: 15 (0.6%), b_comp_prob: 9 (0.4%), b_tok_touch_all: 3.8
        (0.2%), b_finish: 0.81 (0.0%), tests_pri_0: 2312 (94.4%),
        check_dkim_signature: 1.06 (0.0%), check_dkim_adsp: 4.1 (0.2%),
        tests_pri_500: 7 (0.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net 1/1 v2] rtnetlink: require unique netns identifier
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@canonical.com> writes:

> On Tue, Feb 06, 2018 at 12:47:46AM +0300, Kirill Tkhai wrote:
>> On 05.02.2018 18:55, Christian Brauner wrote:
>> > Since we've added support for IFLA_IF_NETNSID for RTM_{DEL,GET,SET,NEW}LINK
>> > it is possible for userspace to send us requests with three different
>> > properties to identify a target network namespace. This affects at least
>> > RTM_{NEW,SET}LINK. Each of them could potentially refer to a different
>> > network namespace which is confusing. For legacy reasons the kernel will
>> > pick the IFLA_NET_NS_PID property first and then look for the
>> > IFLA_NET_NS_FD property but there is no reason to extend this type of
>> > behavior to network namespace ids. The regression potential is quite
>> > minimal since the rtnetlink requests in question either won't allow
>> > IFLA_IF_NETNSID requests before 4.16 is out (RTM_{NEW,SET}LINK) or don't
>> > support IFLA_NET_NS_{PID,FD} (RTM_{DEL,GET}LINK) in the first place.
>> >> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
>> > ---
>> > ChangeLog v1->v2:
>> > * return errno when the specified network namespace id is invalid
>> > * fill in struct netlink_ext_ack if the network namespace id is invalid
>> > * rename rtnl_ensure_unique_netns_attr() to rtnl_ensure_unique_netns() to
>> >   indicate that a request without any network namespace identifying attributes
>> >   is also considered valid.
>> > 
>> > ChangeLog v0->v1:
>> > * report a descriptive error to userspace via struct netlink_ext_ack
>> > * do not fail when multiple properties specifiy the same network namespace
>> > ---
>> >  net/core/rtnetlink.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 69 insertions(+)
>> > 
>> > diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>> > index 56af8e41abfc..c096c4ff9a00 100644
>> > --- a/net/core/rtnetlink.c
>> > +++ b/net/core/rtnetlink.c
>> > @@ -1951,6 +1951,59 @@ static struct net *rtnl_link_get_net_capable(const struct sk_buff *skb,
>> >  	return net;
>> >  }
>> >  
>> > +/* Verify that rtnetlink requests supporting network namespace ids
>> > + * do not pass additional properties referring to different network
>> > + * namespaces.
>> > + */
>> > +static int rtnl_ensure_unique_netns(const struct sock *sk, struct nlattr *tb[],
>> > +				    struct netlink_ext_ack *extack)
>> > +{
>> > +	int ret = -EINVAL;
>> > +	struct net *net = NULL, *unique_net = NULL;
>> > +
>> > +	/* Requests without network namespace ids have been able to specify
>> > +	 * multiple properties referring to different network namespaces so
>> > +	 * don't regress them.
>> > +	 */
>> > +	if (!tb[IFLA_IF_NETNSID])
>> > +		return 0;
>> > +
>> > +	/* Caller operates on the current network namespace. */
>> > +	if (!tb[IFLA_NET_NS_PID] && !tb[IFLA_NET_NS_FD])
>> > +		return 0;
>> > +
>> > +	unique_net = get_net_ns_by_id(sock_net(sk), nla_get_s32(tb[IFLA_IF_NETNSID]));
>> > +	if (!unique_net) {
>> > +		NL_SET_ERR_MSG(extack, "invalid network namespace id");
>> > +		return ret;
>> > +	}
>> > +
>> > +	if (tb[IFLA_NET_NS_PID]) {
>> > +		net = get_net_ns_by_pid(nla_get_u32(tb[IFLA_NET_NS_PID]));
>> > +		if (net != unique_net)
>> > +			goto on_error;
>> > +	}
>> > +
>> > +	if (tb[IFLA_NET_NS_FD]) {
>> > +		net = get_net_ns_by_fd(nla_get_u32(tb[IFLA_NET_NS_FD]));
>> > +		if (net != unique_net)
>> > +			goto on_error;
>> > +	}
>> > +
>> > +	ret = 0;
>> > +
>> > +on_error:
>> > +	put_net(unique_net);
>> > +
>> > +	if (net && !IS_ERR(net))
>> > +		put_net(net);
>> 
>> 1)When we have tb[IFLA_NET_NS_PID and tb[IFLA_NET_NS_FD] both set and pointing
>> to the same net, this function increments net::count in get_net_ns_by_pid() and
>> in get_net_ns_by_fd(), i.e. twice. But only single put_net(net) will be called.
>> So, after this function net::count will be incremented by 1, and it never will
>> die.
>
> Thanks for spotting this, Kirill.
>
>> 
>> 2)The whole approach does not seem good for me. The first reason is it's racy.
>> Even if rtnl_ensure_unique_netns() returns 0, this does not guarantees that
>> tb[IFLA_IF_NETNSID] and tb[IFLA_NET_NS_PID] will be point the same net later,
>> as the pid may die or do setns(). Racy check is worse than no check at all.
>> 
>> The second reason is after this patch get_net_ns_by_id/get_net_ns_by_pid()/
>> get_net_ns_by_fd() will be called twice: the first time is in your check
>> and the second time is where they are actually used. This is not good for
>> performance.
>
> If this is really a performance problem we can simply fix this by
> performing the check when the target network namespace is retrieved in
> each request. The intention for doing it in one function at the
> beginning of each request was to make it generic and easily
> understandable.
>
>> 
>> What is the problem people pass several different tb[xxx] in one call? We
>> may just describe the order of tb[xxx] in man page and their priorities,
>> and ignore the rest after the first not zero tb[xxx] is found, and do that
>> in the place, where net from tb[xxx] in actually used. This is the thing
>> we already do.
>> 
>> Comparing to classic Linux interface such as syscalls, it's usual behavior
>> for them to ignore one argument, when another is set. Nobody confuses.
>
> From what I gather from recent discussions I had here using pids and
> fds to perform operations on network namespaces in netlink requests is
> not the future. Specifically, using pids and fds will not be extended to
> existing or future requests that do not already support it.

Pids are essentially deprecated in that fashion.  At one point they were
the best we had.  File descriptors will not be.

The use case for a netnsid and for a fd to identify network namespaces
are very different.

With netnsid's you have a strongly related set of network namespaces
that are cooperating in some way.  File descriptors don't need to assume
any kind of association between network namespaces.

Plus there are some very real costs to netnsid's that file descriptor's
don't have.

> It also very much smells like a security liability if what you've
> outlined above is true: a user sends a request with a pid and the task
> dies and the pid gets recycled. Now, we can't easily fix this by simply
> ignoring pids and fds from here on since this would likely break a bunch
> of userspace programs but we can ensure that if a network namespace
> identifier is passed that no other way of retrieving the target network
> namespace is passed. Especially with requests that already support pids
> and fds. It's either that or reversing the order meaning that if a
> network namespace identifier is passed then it should take precedence
> over the other identifiers. Furthermore, this would also clearly
> indicate that netns ids are the preferred way to perform operations on
> network namespaces via netlink requests.

Frankly.  If we are talking precedence it should be:
fds
netnsids
pids


I do think it makes a lot of sense to error if someone passes in
duplicate arguments.  AKA multiple attribute that could select for
the same thing.   No one will do that deliberately.  It doesn't make
sense.  So it is just a nonsense case we have to handle gracefully,
and correctly.  With correctness being the most important as otherwise
people might just send in nonsense to exploit bugs.

Typically sending errors can be done statelessly.  So it has the lowest
risk.

> What is certainly a good point is that if pids and fds are as you said
> inherently racy then we shouldn't perform the check but do what my
> original patch did and simply refuse to combine netns ids with pids
> and/or fds.

I agree refusing to combine multiple attributes for the same thing
sounds the most sensible course.

Eric
