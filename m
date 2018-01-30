Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeA3Q0U (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 11:26:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53252 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeA3Q0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 11:26:19 -0500
X-Google-Smtp-Source: AH8x227J/KOrugdK3v/lwxOYaB1ZCfn19WrSt0WnWzIf/MLxQUc439pIBm+IvcAyNUyUP1/Z0aGO/w==
Date: Tue, 30 Jan 2018 17:26:15 +0100
From: Christian Brauner <christian.brauner@canonical.com>
To: kbuild test robot <lkp@intel.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>, kbuild-all@01.org,
        netdev@vger.kernel.org, ebiederm@xmission.com, dsahern@gmail.com,
        fw@strlen.de, daniel@iogearbox.net, lucien.xin@gmail.com,
        mschiffer@universe-factory.net, jakub.kicinski@netronome.com,
        vyasevich@gmail.com, linux-kernel@vger.kernel.org, jbenc@redhat.com,
        w.bumiller@proxmox.com, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 1/1] rtnetlink: enable IFLA_IF_NETNSID for
 RTM_NEWLINK
Message-ID: <20180130162614.hosa3av7o2issdcq@gmail.com>
References: <20180129170720.29724-2-christian.brauner@ubuntu.com>
 <201801310038.YTg1vb4V%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201801310038.YTg1vb4V%fengguang.wu@intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Jan 31, 2018 at 12:13:11AM +0800, kbuild test robot wrote:
> Hi Christian,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on net-next/master]
> 
> url:    https://github.com/0day-ci/linux/commits/Christian-Brauner/rtnetlink-enable-IFLA_IF_NETNSID-for-RTM_NEWLINK/20180130-230918
> config: i386-randconfig-a1-201804 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    net/core/rtnetlink.c: In function 'rtnl_newlink':
> >> net/core/rtnetlink.c:2903:3: error: implicit declaration of function 'rtnl_link_get_net_capable' [-Werror=implicit-function-declaration]
>       dest_net = rtnl_link_get_net_capable(skb, net, tb, CAP_NET_ADMIN);
>       ^

The patch is against Dave's net-next tree which already contains a
merged prior patch series from me which introduces the missing
function. So I'd say this is safe to ignore.

Thanks!
Christian

>    net/core/rtnetlink.c:2903:12: warning: assignment makes pointer from integer without a cast
>       dest_net = rtnl_link_get_net_capable(skb, net, tb, CAP_NET_ADMIN);
>                ^
>    cc1: some warnings being treated as errors
> 
> vim +/rtnl_link_get_net_capable +2903 net/core/rtnetlink.c
> 
>   2729	
>   2730	static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   2731				struct netlink_ext_ack *extack)
>   2732	{
>   2733		struct net *net = sock_net(skb->sk);
>   2734		const struct rtnl_link_ops *ops;
>   2735		const struct rtnl_link_ops *m_ops = NULL;
>   2736		struct net_device *dev;
>   2737		struct net_device *master_dev = NULL;
>   2738		struct ifinfomsg *ifm;
>   2739		char kind[MODULE_NAME_LEN];
>   2740		char ifname[IFNAMSIZ];
>   2741		struct nlattr *tb[IFLA_MAX+1];
>   2742		struct nlattr *linkinfo[IFLA_INFO_MAX+1];
>   2743		unsigned char name_assign_type = NET_NAME_USER;
>   2744		int err;
>   2745	
>   2746	#ifdef CONFIG_MODULES
>   2747	replay:
>   2748	#endif
>   2749		err = nlmsg_parse(nlh, sizeof(*ifm), tb, IFLA_MAX, ifla_policy, extack);
>   2750		if (err < 0)
>   2751			return err;
>   2752	
>   2753		if (tb[IFLA_IF_NETNSID])
>   2754			return -EOPNOTSUPP;
>   2755	
>   2756		if (tb[IFLA_IFNAME])
>   2757			nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
>   2758		else
>   2759			ifname[0] = '\0';
>   2760	
>   2761		ifm = nlmsg_data(nlh);
>   2762		if (ifm->ifi_index > 0)
>   2763			dev = __dev_get_by_index(net, ifm->ifi_index);
>   2764		else {
>   2765			if (ifname[0])
>   2766				dev = __dev_get_by_name(net, ifname);
>   2767			else
>   2768				dev = NULL;
>   2769		}
>   2770	
>   2771		if (dev) {
>   2772			master_dev = netdev_master_upper_dev_get(dev);
>   2773			if (master_dev)
>   2774				m_ops = master_dev->rtnl_link_ops;
>   2775		}
>   2776	
>   2777		err = validate_linkmsg(dev, tb);
>   2778		if (err < 0)
>   2779			return err;
>   2780	
>   2781		if (tb[IFLA_LINKINFO]) {
>   2782			err = nla_parse_nested(linkinfo, IFLA_INFO_MAX,
>   2783					       tb[IFLA_LINKINFO], ifla_info_policy,
>   2784					       NULL);
>   2785			if (err < 0)
>   2786				return err;
>   2787		} else
>   2788			memset(linkinfo, 0, sizeof(linkinfo));
>   2789	
>   2790		if (linkinfo[IFLA_INFO_KIND]) {
>   2791			nla_strlcpy(kind, linkinfo[IFLA_INFO_KIND], sizeof(kind));
>   2792			ops = rtnl_link_ops_get(kind);
>   2793		} else {
>   2794			kind[0] = '\0';
>   2795			ops = NULL;
>   2796		}
>   2797	
>   2798		if (1) {
>   2799			struct nlattr *attr[ops ? ops->maxtype + 1 : 1];
>   2800			struct nlattr *slave_attr[m_ops ? m_ops->slave_maxtype + 1 : 1];
>   2801			struct nlattr **data = NULL;
>   2802			struct nlattr **slave_data = NULL;
>   2803			struct net *dest_net, *link_net = NULL;
>   2804	
>   2805			if (ops) {
>   2806				if (ops->maxtype && linkinfo[IFLA_INFO_DATA]) {
>   2807					err = nla_parse_nested(attr, ops->maxtype,
>   2808							       linkinfo[IFLA_INFO_DATA],
>   2809							       ops->policy, NULL);
>   2810					if (err < 0)
>   2811						return err;
>   2812					data = attr;
>   2813				}
>   2814				if (ops->validate) {
>   2815					err = ops->validate(tb, data, extack);
>   2816					if (err < 0)
>   2817						return err;
>   2818				}
>   2819			}
>   2820	
>   2821			if (m_ops) {
>   2822				if (m_ops->slave_maxtype &&
>   2823				    linkinfo[IFLA_INFO_SLAVE_DATA]) {
>   2824					err = nla_parse_nested(slave_attr,
>   2825							       m_ops->slave_maxtype,
>   2826							       linkinfo[IFLA_INFO_SLAVE_DATA],
>   2827							       m_ops->slave_policy,
>   2828							       NULL);
>   2829					if (err < 0)
>   2830						return err;
>   2831					slave_data = slave_attr;
>   2832				}
>   2833			}
>   2834	
>   2835			if (dev) {
>   2836				int status = 0;
>   2837	
>   2838				if (nlh->nlmsg_flags & NLM_F_EXCL)
>   2839					return -EEXIST;
>   2840				if (nlh->nlmsg_flags & NLM_F_REPLACE)
>   2841					return -EOPNOTSUPP;
>   2842	
>   2843				if (linkinfo[IFLA_INFO_DATA]) {
>   2844					if (!ops || ops != dev->rtnl_link_ops ||
>   2845					    !ops->changelink)
>   2846						return -EOPNOTSUPP;
>   2847	
>   2848					err = ops->changelink(dev, tb, data, extack);
>   2849					if (err < 0)
>   2850						return err;
>   2851					status |= DO_SETLINK_NOTIFY;
>   2852				}
>   2853	
>   2854				if (linkinfo[IFLA_INFO_SLAVE_DATA]) {
>   2855					if (!m_ops || !m_ops->slave_changelink)
>   2856						return -EOPNOTSUPP;
>   2857	
>   2858					err = m_ops->slave_changelink(master_dev, dev,
>   2859								      tb, slave_data,
>   2860								      extack);
>   2861					if (err < 0)
>   2862						return err;
>   2863					status |= DO_SETLINK_NOTIFY;
>   2864				}
>   2865	
>   2866				return do_setlink(skb, dev, ifm, extack, tb, ifname,
>   2867						  status);
>   2868			}
>   2869	
>   2870			if (!(nlh->nlmsg_flags & NLM_F_CREATE)) {
>   2871				if (ifm->ifi_index == 0 && tb[IFLA_GROUP])
>   2872					return rtnl_group_changelink(skb, net,
>   2873							nla_get_u32(tb[IFLA_GROUP]),
>   2874							ifm, extack, tb);
>   2875				return -ENODEV;
>   2876			}
>   2877	
>   2878			if (tb[IFLA_MAP] || tb[IFLA_PROTINFO])
>   2879				return -EOPNOTSUPP;
>   2880	
>   2881			if (!ops) {
>   2882	#ifdef CONFIG_MODULES
>   2883				if (kind[0]) {
>   2884					__rtnl_unlock();
>   2885					request_module("rtnl-link-%s", kind);
>   2886					rtnl_lock();
>   2887					ops = rtnl_link_ops_get(kind);
>   2888					if (ops)
>   2889						goto replay;
>   2890				}
>   2891	#endif
>   2892				return -EOPNOTSUPP;
>   2893			}
>   2894	
>   2895			if (!ops->setup)
>   2896				return -EOPNOTSUPP;
>   2897	
>   2898			if (!ifname[0]) {
>   2899				snprintf(ifname, IFNAMSIZ, "%s%%d", ops->kind);
>   2900				name_assign_type = NET_NAME_ENUM;
>   2901			}
>   2902	
> > 2903			dest_net = rtnl_link_get_net_capable(skb, net, tb, CAP_NET_ADMIN);
>   2904			if (IS_ERR(dest_net))
>   2905				return PTR_ERR(dest_net);
>   2906	
>   2907			if (tb[IFLA_LINK_NETNSID]) {
>   2908				int id = nla_get_s32(tb[IFLA_LINK_NETNSID]);
>   2909	
>   2910				link_net = get_net_ns_by_id(dest_net, id);
>   2911				if (!link_net) {
>   2912					err =  -EINVAL;
>   2913					goto out;
>   2914				}
>   2915				err = -EPERM;
>   2916				if (!netlink_ns_capable(skb, link_net->user_ns, CAP_NET_ADMIN))
>   2917					goto out;
>   2918			}
>   2919	
>   2920			dev = rtnl_create_link(link_net ? : dest_net, ifname,
>   2921					       name_assign_type, ops, tb);
>   2922			if (IS_ERR(dev)) {
>   2923				err = PTR_ERR(dev);
>   2924				goto out;
>   2925			}
>   2926	
>   2927			dev->ifindex = ifm->ifi_index;
>   2928	
>   2929			if (ops->newlink) {
>   2930				err = ops->newlink(link_net ? : net, dev, tb, data,
>   2931						   extack);
>   2932				/* Drivers should call free_netdev() in ->destructor
>   2933				 * and unregister it on failure after registration
>   2934				 * so that device could be finally freed in rtnl_unlock.
>   2935				 */
>   2936				if (err < 0) {
>   2937					/* If device is not registered at all, free it now */
>   2938					if (dev->reg_state == NETREG_UNINITIALIZED)
>   2939						free_netdev(dev);
>   2940					goto out;
>   2941				}
>   2942			} else {
>   2943				err = register_netdevice(dev);
>   2944				if (err < 0) {
>   2945					free_netdev(dev);
>   2946					goto out;
>   2947				}
>   2948			}
>   2949			err = rtnl_configure_link(dev, ifm);
>   2950			if (err < 0)
>   2951				goto out_unregister;
>   2952			if (link_net) {
>   2953				err = dev_change_net_namespace(dev, dest_net, ifname);
>   2954				if (err < 0)
>   2955					goto out_unregister;
>   2956			}
>   2957			if (tb[IFLA_MASTER]) {
>   2958				err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]),
>   2959						    extack);
>   2960				if (err)
>   2961					goto out_unregister;
>   2962			}
>   2963	out:
>   2964			if (link_net)
>   2965				put_net(link_net);
>   2966			put_net(dest_net);
>   2967			return err;
>   2968	out_unregister:
>   2969			if (ops->newlink) {
>   2970				LIST_HEAD(list_kill);
>   2971	
>   2972				ops->dellink(dev, &list_kill);
>   2973				unregister_netdevice_many(&list_kill);
>   2974			} else {
>   2975				unregister_netdevice(dev);
>   2976			}
>   2977			goto out;
>   2978		}
>   2979	}
>   2980	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
