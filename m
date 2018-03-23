Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756013AbeCWLI6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 07:08:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45677 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752580AbeCWLIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 07:08:53 -0400
Message-ID: <1521803301.3406.4.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/8] reset: modify the way reset lookup works for
 board files
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 23 Mar 2018 12:08:21 +0100
In-Reply-To: <CAMRc=Mcf18jmRAM6WFBnuuOen11+5uzy4yo3xwvLQzLBSSNvHQ@mail.gmail.com>
References: <20180323093609.24576-1-brgl@bgdev.pl>
         <20180323093609.24576-2-brgl@bgdev.pl>
         <1521800670.3406.1.camel@pengutronix.de>
         <CAMRc=Mcf18jmRAM6WFBnuuOen11+5uzy4yo3xwvLQzLBSSNvHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-23 at 11:46 +0100, Bartosz Golaszewski wrote:
> 2018-03-23 11:24 GMT+01:00 Philipp Zabel <p.zabel@pengutronix.de>:
> > Hi Bartosz,
> > 
> > On Fri, 2018-03-23 at 10:36 +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > 
> > > Commit 7af1bb19f1d7 ("reset: add support for non-DT systems")
> > > introduced reset control lookup mechanism for boards that still use
> > > board files.
> > > 
> > > The routine used to register lookup entries takes the corresponding
> > > reset_controlled_dev structure as argument.
> > > 
> > > It's been determined however that for the first user of this new
> > > interface - davinci psc driver - it will be easier to register the
> > > lookup entries using the reset controller device name.
> > 
> > Thank you, this is what I expected in the first place.
> > 
> > > This patch changes the way lookup entries are added.
> > > 
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > ---
> > >  drivers/reset/core.c             | 33 +++++++++++++++++++++++++++++----
> > >  include/linux/reset-controller.h |  8 +++++---
> > >  2 files changed, 34 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > > index 06fa4907afc4..f37048e55336 100644
> > > --- a/drivers/reset/core.c
> > > +++ b/drivers/reset/core.c
> > > @@ -153,11 +153,11 @@ EXPORT_SYMBOL_GPL(devm_reset_controller_register);
> > > 
> > >  /**
> > >   * reset_controller_add_lookup - register a set of lookup entries
> > > - * @rcdev: initialized reset controller device owning the reset line
> > > + * @provider: name of the reset controller provider
> > >   * @lookup: array of reset lookup entries
> > >   * @num_entries: number of entries in the lookup array
> > >   */
> > > -void reset_controller_add_lookup(struct reset_controller_dev *rcdev,
> > > +void reset_controller_add_lookup(const char *provider,
> > 
> > Is there any reason not to drop the provider parameter completely?
> > I'd just let the user add the provider device id to the lookup, see
> > below.
> > 
> > >                                struct reset_control_lookup *lookup,
> > >                                unsigned int num_entries)
> > >  {
> > > @@ -174,7 +174,7 @@ void reset_controller_add_lookup(struct reset_controller_dev *rcdev,
> > >                       continue;
> > >               }
> > > 
> > > -             entry->rcdev = rcdev;
> > > +             entry->provider = provider;
> > >               list_add_tail(&entry->list, &reset_lookup_list);
> > >       }
> > >       mutex_unlock(&reset_lookup_mutex);
> > > @@ -526,11 +526,30 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
> > >  }
> > >  EXPORT_SYMBOL_GPL(__of_reset_control_get);
> > > 
> > > +static struct reset_controller_dev *
> > > +__reset_controller_by_name(const char *name)
> > > +{
> > > +     struct reset_controller_dev *rcdev;
> > > +
> > > +     lockdep_assert_held(&reset_list_mutex);
> > > +
> > > +     list_for_each_entry(rcdev, &reset_controller_list, list) {
> > > +             if (!rcdev->dev)
> > > +                     continue;
> > > +
> > > +             if (!strcmp(name, dev_name(rcdev->dev)))
> > > +                     return rcdev;
> > > +     }
> > > +
> > > +     return NULL;
> > > +}
> > > +
> > >  static struct reset_control *
> > >  __reset_control_get_from_lookup(struct device *dev, const char *con_id,
> > >                               bool shared, bool optional)
> > >  {
> > >       const struct reset_control_lookup *lookup;
> > > +     struct reset_controller_dev *rcdev;
> > >       const char *dev_id = dev_name(dev);
> > >       struct reset_control *rstc = NULL;
> > > 
> > > @@ -547,7 +566,13 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
> > >                   ((con_id && lookup->con_id) &&
> > >                    !strcmp(con_id, lookup->con_id))) {
> > >                       mutex_lock(&reset_list_mutex);
> > > -                     rstc = __reset_control_get_internal(lookup->rcdev,
> > > +                     rcdev = __reset_controller_by_name(lookup->provider);
> > > +                     if (!rcdev) {
> > > +                             mutex_unlock(&reset_list_mutex);
> > > +                             continue;
> > 
> > What is the reason to continue here? If we've found a matching lookup
> > that contains a rcdev dev_id for which there is no reset controller,
> > shouldn't we just return an error?
> > 
> 
> Indeed. This could be used to indicate to drivers that the reset
> controller may not have yet been probed() or its probe() failed. How
> about returning -EPROBE_DEFER here?

That is a good point. The framework doesn't know whether the
lookup->provider is bogus or whether it's correct and the corresponding
driver just hasn't registered its reset controller yet. So we have to
assume the latter and return -EPROBE_DEFER here.

> Bart
> 
> > > +                     }
> > > +
> > > +                     rstc = __reset_control_get_internal(rcdev,
> > >                                                           lookup->index,
> > >                                                           shared);
> > >                       mutex_unlock(&reset_list_mutex);
> > > diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
> > > index 25698f6c1fae..1a6c25d825d3 100644
> > > --- a/include/linux/reset-controller.h
> > > +++ b/include/linux/reset-controller.h
> > > @@ -30,14 +30,14 @@ struct of_phandle_args;
> > >   * struct reset_control_lookup - represents a single lookup entry
> > >   *
> > >   * @list: internal list of all reset lookup entries
> > > - * @rcdev: reset controller device controlling this reset line
> > > + * @provider: name of the reset controller device controlling this reset line
> > >   * @index: ID of the reset controller in the reset controller device
> > >   * @dev_id: name of the device associated with this reset line
> > >   * @con_id name of the reset line (can be NULL)
> > >   */
> > >  struct reset_control_lookup {
> > >       struct list_head list;
> > > -     struct reset_controller_dev *rcdev;
> > > +     const char *provider;
> > 
> > Looks good to me, but I'd also extend RESET_LOOKUP to set the provider
> > instead of passing it to the reset_controller_add_lookup function,
> > similarly to PWM_LOOKUP:
> > 
> > #define RESET_LOOKUP(_provider, _index, _dev_id, _con_id)
> > 
> 
> I did it mostly for brevity - I don't mind changing it if you prefer
> this version.

Yes, please. I like the consistency, and seeing provider and index right
next to each other will make the lookups easier to read and understand.

regards
Philipp
