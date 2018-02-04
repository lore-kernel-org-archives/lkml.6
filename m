Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbeBDCJo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 21:09:44 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:36951 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBDCJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 21:09:39 -0500
X-Google-Smtp-Source: AH8x227at7uQuXvIDQAKpNSuuN2y31nB9VFVV1g8Lcw44EZUOyvlhBbk1O7YluhkmIlsJVGXaEszHQ==
Subject: Re: [PATCH net 1/1 v1] rtnetlink: require unique netns identifier
To: Stephen Hemminger <stephen@networkplumber.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc: netdev@vger.kernel.org, ebiederm@xmission.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org,
        davem@davemloft.net
References: <20180203132904.11972-1-christian.brauner@ubuntu.com>
 <20180203132904.11972-2-christian.brauner@ubuntu.com>
 <20180203111701.2ff8d7a3@xeon-e3>
From: David Ahern <dsahern@gmail.com>
Message-ID: <0e8a86e6-5948-1e91-d937-893eb62ceef1@gmail.com>
Date: Sat, 3 Feb 2018 19:09:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180203111701.2ff8d7a3@xeon-e3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/18 12:17 PM, Stephen Hemminger wrote:
> On Sat,  3 Feb 2018 14:29:04 +0100
> Christian Brauner <christian.brauner@ubuntu.com> wrote:
> 
>> +static int rtnl_ensure_unique_netns_attr(const struct sock *sk,
>> +					 struct nlattr *tb[],
>> +					 struct netlink_ext_ack *extack)
>> +{
>> +	int ret = -EINVAL;
>> +	struct net *net = NULL, *unique_net = NULL;
>> +
>> +	/* Requests without network namespace ids have been able to specify
>> +	 * multiple properties referring to different network namespaces so
>> +	 * don't regress them.
>> +	 */
>> +	if (!tb[IFLA_IF_NETNSID])
>> +		return 0;
>> +
>> +	if (!tb[IFLA_NET_NS_PID] && !tb[IFLA_NET_NS_FD])
>> +		return 0;
> 
> Isn't this an error?
> 
>> +
>> +	unique_net = get_net_ns_by_id(sock_net(sk), nla_get_s32(tb[IFLA_IF_NETNSID]));
>> +	if (!unique_net)
>> +		return -1;
> 
> Other paths are returning errno, so why -1 here?
> 

extack needs to be filled in too.
