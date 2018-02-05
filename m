Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbeBEPOs convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:14:48 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:33790 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753237AbeBEPOi (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:6:1>);
        Mon, 5 Feb 2018 10:14:38 -0500
Message-Id: <5A7882EA02000078001A552D@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Mon, 05 Feb 2018 08:14:34 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "David Laight" <David.Laight@aculab.com>,
        <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH] [v2] xen: hypercall: fix out-of-bounds
 memcpy
References: <20180205150340.328921-1-arnd@arndb.de>
In-Reply-To: <20180205150340.328921-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 05.02.18 at 16:03, <arnd@arndb.de> wrote:
>  int xen_event_channel_op_compat(int cmd, void *arg)
>  {
> -	struct evtchn_op op;
> +	struct evtchn_op op = { .cmd = cmd, };
> +	size_t len;
>  	int rc;
>  
> -	op.cmd = cmd;
> -	memcpy(&op.u, arg, sizeof(op.u));
> -	rc = _hypercall1(int, event_channel_op_compat, &op);
> -
> -	switch (cmd) {
> -	case EVTCHNOP_close:
> -	case EVTCHNOP_send:
> -	case EVTCHNOP_bind_vcpu:
> -	case EVTCHNOP_unmask:
> -		/* no output */
> -		break;
> +	if (cmd > ARRAY_SIZE(evtchnop_len))
> +		return -ENOSYS;

>= perhaps?

Jan
