Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AH8x227p4xUEf/3EOOoiPAHcaWm4AiJmE9wCB/ctxbKsDlcEQZlToUKMsWq1h8QIVIophuTYF4q5
ARC-Seal: i=1; a=rsa-sha256; t=1518790934; cv=none;
        d=google.com; s=arc-20160816;
        b=Spve0lMHgK3HchFdpk0gUqeqUau5+d9Wb5SegeaU9pujHCgJhuSg59+W0/VobtIq3H
         tOtEaT+M43cGaFC/Pn/Vy99dpW3VbGuBz15q23DhFworrs2bEpdhj95/SLiFoRWoN1yn
         rYXqNKyB+07QP+HJGyXqfdzmJuQeW0GP3bRK/Ck+sEgHaDV0VzIe4+yGhbOTbavJXeVm
         GZVRDLSqPx34Dfxf3S45iKreI1YyendlmTEdndC3pmd0WoPfIFqGSjiZCWQhx2b0FbYF
         9EmESnyIpw2kyDvSNDOlFrKKPojSQv0SMVIsSiWFMgQqkEAuhnlYbKI9CTDBg865HhKr
         w0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=sl4pidLqP+Eah69SrDeuu0LgXlLV2fPM4bezfjGhoBw=;
        b=IM8B5WleUYp7rgWAfqI9sFvpLJ/DeXkU8yhrdGYB590p74i9dW1bY7+2JfJ3YsRhnB
         W3jaDRiyDNgKSb2L/PcmazVYxxCXw1HUx5AjtdnuU7CdAp8A2Zk8o2a3cBfJ7Hd5N/X6
         8ZwBVUKPYOFRfECDwaS0TPE+jr9lO9TVfhGDZsVGIEX/RYgT/4Yot3YgVsRFh0YnF6vc
         +sz3deZ995RAMtN2XHsKVmmGu07R2GmYUbhBAtnij5m8ayi1axLIVjToiqvYEaeBtU+q
         5rC8dQ+tg7WTGLWdoBMGJas2AsRXA7UCcOILvHDGSTN0hTITSN5CfkChhmXN29iYeR0J
         R8qA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="31377285"
Date: Fri, 16 Feb 2018 16:22:09 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Platform Driver <platform-driver-x86@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	USB <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 04/12] usb: common: Small class for USB role switches
Message-ID: <20180216142209.GS1480@kuha.fi.intel.com>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-5-hdegoede@redhat.com>
 <CAHp75VcU1CUN5A9qFw4mDGjdeD+mtSWxx-YwtkaAXkUdcmcwpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcU1CUN5A9qFw4mDGjdeD+mtSWxx-YwtkaAXkUdcmcwpg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592554245536279183?=
X-GMAIL-MSGID: =?utf-8?q?1592567722892145553?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 04:07:59PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 16, 2018 at 12:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> 
> > USB role switch is a device that can be used to choose the
> > data role for USB connector. With dual-role capable USB
> > controllers, the controller itself will be the switch, but
> > on some platforms the USB host and device controllers are
> > separate IPs and there is a mux between them and the
> > connector. On those platforms the mux driver will need to
> > register the switch.
> >
> > With USB Type-C connectors, the host-to-device relationship
> > is negotiated over the Configuration Channel (CC). That
> > means the USB Type-C drivers need to be in control of the
> > role switch. The class provides a simple API for the USB
> > Type-C drivers for the control.
> >
> > For other types of USB connectors (mainly microAB) the class
> > provides user space control via sysfs attribute file that
> > can be used to request role swapping from the switch.
> 
> > +static int __switch_match(struct device *dev, const void *name)
> 
> bool?

No, this is callback for class_find_device(). It takes int so int it
is.

> > +{
> > +       return !strcmp((const char *)name, dev_name(dev));
> > +}
> 
> 
> > +static ssize_t role_store(struct device *dev, struct device_attribute *attr,
> > +                         const char *buf, size_t size)
> > +{
> > +       struct usb_role_switch *sw = to_role_switch(dev);
> > +       int ret;
> > +
> > +       ret = sysfs_match_string(usb_roles, buf);
> > +       if (ret < 0) {
> > +               bool res;
> > +
> > +               /* Extra check if the user wants to disable the switch */
> > +               ret = kstrtobool(buf, &res);
> > +               if (ret || res)
> > +                       return -EINVAL;
> > +       }
> > +
> 
> > +       ret = usb_role_switch_set_role(sw, ret);
> > +       if (!ret)
> > +               ret = size;
> > +
> > +       return ret;
> 
> Perhaps
> 
> ret = ...
> if (ret)
>  return ret;
> 
> return size;

Sure. Hans, can you clean-up this as well?

> > +}
> 
> > +struct usb_role_switch *
> > +usb_role_switch_register(struct device *parent,
> > +                        const struct usb_role_switch_desc *desc)
> > +{
> > +       struct usb_role_switch *sw;
> > +       int ret;
> > +
> > +       if (!desc || !desc->set)
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       sw = kzalloc(sizeof(*sw), GFP_KERNEL);
> > +       if (!sw)
> > +               return ERR_PTR(-ENOMEM);
> 
> > +       ret = device_register(&sw->dev);
> > +       if (ret) {
> > +               put_device(&sw->dev);
> 
> Memory leak?

No. Check usb_role_switch_release().


Thanks,

-- 
heikki
