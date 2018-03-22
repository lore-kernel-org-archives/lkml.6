Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521691385; cv=none;
        d=google.com; s=arc-20160816;
        b=jCPtXgnSfs9/rHFhmSxYOfrJux7xhh9GxK2dty7kdU9UiAINGxbY7XdnqUgHq8dmXT
         x0sydzTw3lDLf1Z9YwR8l4BsUh69Wb5XNr67iZ3ohoXbzzKaRsjjs6dLB1bU5Y8ezhSe
         REfIrXHGZcilHAqiVGMklHWv85aKSyfSpDehgYD8KGT+8Jh/RZfwtLI95RcLjtxIZOec
         9rEnsTZNWxCXeTCvSSfUGiEZzIm5iN4yuwpkUppofEh37nTmbWcel22QMpYiLPTSCJs+
         no081OhlbJzuAxUvhg9QtvsZOrw8KqfSHYlBlx7tg+4gEIoTDvc3M0CLi9gkEaobFKfc
         LTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:sender
         :dkim-signature:arc-authentication-results;
        bh=9GxRN4/CsByWFineX6IUR0y/FNwpm5Fcg+wd5FRMolo=;
        b=v/3A+5qMdnjLsTUnYjNaUj3yEAJBnheZwOzULqSxNFyhWNEWu5CCOtK61ABB2Dlg6d
         IfPIJjuX2BgGLX3lJv9muvjLimliHQSUC1E8IgTQeWiRUnbDfXxNNup9KxS0ewK9q5L6
         IZTBFjTLthFlIoHA0n28sciId2A9OCm//NGSMyt6rrngzp+R+bLvSE9w+biQ/OjrCJ6j
         aAeVO2w/Jp0wkSD7AZE1n/av2ITPA5acV1p68dk/4HMs9yLeisAHKuob6mDuqCV8KtG6
         x15YqjgHnsGCS/DC8UUmTgHFl/vpTDAdUE5Q8uP6TSsJsGNdKQpnWjCw6+SiokVny/NQ
         7HjA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Mdy3w/Xk;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Mdy3w/Xk;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AG47ELsvx2Ksulbp5ACwX+1oVJgb1PoopGvi7pxuexbhvwehYmay7YAAqFCq2hFqs7qT4S58Q42CjQ==
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v5 1/5] typec: tcpm: Add core support for sink side PPS
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Jun Li <jun.li@nxp.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, support.opensource@diasemi.com
References: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <dc50ec940a1e18059a87bca3c96e2dd539f9efa7.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a6d1b2f9-e750-5914-4807-79fc89d26bb5@roeck-us.net>
Date: Wed, 21 Mar 2018 21:03:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <dc50ec940a1e18059a87bca3c96e2dd539f9efa7.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595467549835107459?=
X-GMAIL-MSGID: =?utf-8?q?1595609065872824264?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/20/2018 07:33 AM, Adam Thomson wrote:
> This commit adds code to handle requesting of PPS APDOs. Switching
> between standard PDOs and APDOs, and re-requesting an APDO to
> modify operating voltage/current will be triggered by an
> external call into TCPM.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>   drivers/usb/typec/tcpm.c | 524 +++++++++++++++++++++++++++++++++++++++++++++--
>   include/linux/usb/pd.h   |   4 +-
>   include/linux/usb/tcpm.h |   2 +-
>   3 files changed, 513 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index 4c0fc54..b4cf1ca 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -47,6 +47,7 @@
>   	S(SNK_DISCOVERY_DEBOUNCE_DONE),		\
>   	S(SNK_WAIT_CAPABILITIES),		\
>   	S(SNK_NEGOTIATE_CAPABILITIES),		\
> +	S(SNK_NEGOTIATE_PPS_CAPABILITIES),	\
>   	S(SNK_TRANSITION_SINK),			\
>   	S(SNK_TRANSITION_SINK_VBUS),		\
>   	S(SNK_READY),				\
> @@ -166,6 +167,16 @@ struct pd_mode_data {
>   	struct typec_altmode_desc altmode_desc[SVID_DISCOVERY_MAX];
>   };
>   
> +struct pd_pps_data {
> +	u32 min_volt;
> +	u32 max_volt;
> +	u32 max_curr;
> +	u32 out_volt;
> +	u32 op_curr;
> +	bool supported;
> +	bool active;
> +};
> +
>   struct tcpm_port {
>   	struct device *dev;
>   
> @@ -233,6 +244,7 @@ struct tcpm_port {
>   	struct completion swap_complete;
>   	int swap_status;
>   
> +	unsigned int negotiated_rev;
>   	unsigned int message_id;
>   	unsigned int caps_count;
>   	unsigned int hard_reset_count;
> @@ -259,6 +271,7 @@ struct tcpm_port {
>   	unsigned int max_snk_ma;
>   	unsigned int max_snk_mw;
>   	unsigned int operating_snk_mw;
> +	bool update_sink_caps;
>   
>   	/* Requested current / voltage */
>   	u32 current_limit;
> @@ -275,8 +288,13 @@ struct tcpm_port {
>   	/* VDO to retry if UFP responder replied busy */
>   	u32 vdo_retry;
>   
> -	/* Alternate mode data */
> +	/* PPS */
> +	struct pd_pps_data pps_data;
> +	struct completion pps_complete;
> +	bool pps_pending;
> +	int pps_status;
>   
> +	/* Alternate mode data */
>   	struct pd_mode_data mode_data;
>   	struct typec_altmode *partner_altmode[SVID_DISCOVERY_MAX];
>   	struct typec_altmode *port_altmode[SVID_DISCOVERY_MAX];
> @@ -494,6 +512,16 @@ static void tcpm_log_source_caps(struct tcpm_port *port)
>   				  pdo_max_voltage(pdo),
>   				  pdo_max_power(pdo));
>   			break;
> +		case PDO_TYPE_APDO:
> +			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS)
> +				scnprintf(msg, sizeof(msg),
> +					  "%u-%u mV, %u mA",
> +					  pdo_pps_apdo_min_voltage(pdo),
> +					  pdo_pps_apdo_max_voltage(pdo),
> +					  pdo_pps_apdo_max_current(pdo));
> +			else
> +				strcpy(msg, "undefined APDO");
> +			break;
>   		default:
>   			strcpy(msg, "undefined");
>   			break;
> @@ -777,11 +805,13 @@ static int tcpm_pd_send_source_caps(struct tcpm_port *port)
>   		msg.header = PD_HEADER_LE(PD_CTRL_REJECT,
>   					  port->pwr_role,
>   					  port->data_role,
> +					  port->negotiated_rev,
>   					  port->message_id, 0);
>   	} else {
>   		msg.header = PD_HEADER_LE(PD_DATA_SOURCE_CAP,
>   					  port->pwr_role,
>   					  port->data_role,
> +					  port->negotiated_rev,
>   					  port->message_id,
>   					  port->nr_src_pdo);
>   	}
> @@ -802,11 +832,13 @@ static int tcpm_pd_send_sink_caps(struct tcpm_port *port)
>   		msg.header = PD_HEADER_LE(PD_CTRL_REJECT,
>   					  port->pwr_role,
>   					  port->data_role,
> +					  port->negotiated_rev,
>   					  port->message_id, 0);
>   	} else {
>   		msg.header = PD_HEADER_LE(PD_DATA_SINK_CAP,
>   					  port->pwr_role,
>   					  port->data_role,
> +					  port->negotiated_rev,
>   					  port->message_id,
>   					  port->nr_snk_pdo);
>   	}
> @@ -1173,6 +1205,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>   		msg.header = PD_HEADER_LE(PD_DATA_VENDOR_DEF,
>   					  port->pwr_role,
>   					  port->data_role,
> +					  port->negotiated_rev,
>   					  port->message_id, port->vdo_count);
>   		for (i = 0; i < port->vdo_count; i++)
>   			msg.payload[i] = cpu_to_le32(port->vdo_data[i]);
> @@ -1244,6 +1277,8 @@ enum pdo_err {
>   	PDO_ERR_FIXED_NOT_SORTED,
>   	PDO_ERR_VARIABLE_BATT_NOT_SORTED,
>   	PDO_ERR_DUPE_PDO,
> +	PDO_ERR_PPS_APDO_NOT_SORTED,
> +	PDO_ERR_DUPE_PPS_APDO,
>   };
>   
>   static const char * const pdo_err_msg[] = {
> @@ -1259,6 +1294,10 @@ enum pdo_err {
>   	" err: Variable/Battery supply pdos should be in increasing order of their minimum voltage",
>   	[PDO_ERR_DUPE_PDO] =
>   	" err: Variable/Batt supply pdos cannot have same min/max voltage",
> +	[PDO_ERR_PPS_APDO_NOT_SORTED] =
> +	" err: Programmable power supply apdos should be in increasing order of their maximum voltage",
> +	[PDO_ERR_DUPE_PPS_APDO] =
> +	" err: Programmable power supply apdos cannot have same min/max voltage and max current",
>   };
>   
>   static enum pdo_err tcpm_caps_err(struct tcpm_port *port, const u32 *pdo,
> @@ -1308,6 +1347,26 @@ static enum pdo_err tcpm_caps_err(struct tcpm_port *port, const u32 *pdo,
>   					  pdo_min_voltage(pdo[i - 1])))
>   					return PDO_ERR_DUPE_PDO;
>   				break;
> +			/*
> +			 * The Programmable Power Supply APDOs, if present,
> +			 * shall be sent in Maximum Voltage order;
> +			 * lowest to highest.
> +			 */
> +			case PDO_TYPE_APDO:
> +				if (pdo_apdo_type(pdo[i]) != APDO_TYPE_PPS)
> +					break;
> +
> +				if (pdo_pps_apdo_max_current(pdo[i]) <
> +				    pdo_pps_apdo_max_current(pdo[i - 1]))
> +					return PDO_ERR_PPS_APDO_NOT_SORTED;
> +				else if ((pdo_pps_apdo_min_voltage(pdo[i]) ==
> +					  pdo_pps_apdo_min_voltage(pdo[i - 1])) &&
> +					 (pdo_pps_apdo_max_voltage(pdo[i]) ==
> +					  pdo_pps_apdo_max_voltage(pdo[i - 1])) &&
> +					 (pdo_pps_apdo_max_current(pdo[i]) ==
> +					  pdo_pps_apdo_max_current(pdo[i - 1])))

Unnecessary ( )

> +					return PDO_ERR_DUPE_PPS_APDO;
> +				break;
>   			default:
>   				tcpm_log_force(port, " Unknown pdo type");
>   			}
> @@ -1333,11 +1392,16 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
>   /*
>    * PD (data, control) command handling functions
>    */
> +
> +static int tcpm_pd_send_control(struct tcpm_port *port,
> +				enum pd_ctrl_msg_type type);
> +
>   static void tcpm_pd_data_request(struct tcpm_port *port,
>   				 const struct pd_message *msg)
>   {
>   	enum pd_data_msg_type type = pd_header_type_le(msg->header);
>   	unsigned int cnt = pd_header_cnt_le(msg->header);
> +	unsigned int rev = pd_header_rev_le(msg->header);
>   	unsigned int i;
>   
>   	switch (type) {
> @@ -1356,6 +1420,16 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
>   				   port->nr_source_caps);
>   
>   		/*
> +		 * Adjust revision in subsequent message headers, as required,
> +		 * to comply with 6.2.1.1.5 of the USB PD 3.0 spec. We don't
> +		 * support Rev 1.0 so just do nothing in that scenario.
> +		 */
> +		if (rev == PD_REV10)
> +			break;
> +		else if (rev < PD_MAX_REV)
> +			port->negotiated_rev = rev;
> +
> +		/*
>   		 * This message may be received even if VBUS is not
>   		 * present. This is quite unexpected; see USB PD
>   		 * specification, sections 8.3.3.6.3.1 and 8.3.3.6.3.2.
> @@ -1376,6 +1450,19 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
>   			tcpm_queue_message(port, PD_MSG_CTRL_REJECT);
>   			break;
>   		}
> +
> +		/*
> +		 * Adjust revision in subsequent message headers, as required,
> +		 * to comply with 6.2.1.1.5 of the USB PD 3.0 spec. We don't
> +		 * support Rev 1.0 so just reject in that scenario.
> +		 */
> +		if (rev == PD_REV10) {
> +			tcpm_queue_message(port, PD_MSG_CTRL_REJECT);
> +			break;
> +		} else if (rev < PD_MAX_REV) {
> +			port->negotiated_rev = rev;
> +		}
> +
>   		port->sink_request = le32_to_cpu(msg->payload[0]);
>   		tcpm_set_state(port, SRC_NEGOTIATE_CAPABILITIES, 0);
>   		break;
> @@ -1400,6 +1487,15 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
>   	}
>   }
>   
> +static void tcpm_pps_complete(struct tcpm_port *port, int result)
> +{
> +	if (port->pps_pending) {
> +		port->pps_status = result;
> +		port->pps_pending = false;
> +		complete(&port->pps_complete);
> +	}
> +}
> +
>   static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>   				 const struct pd_message *msg)
>   {
> @@ -1476,6 +1572,14 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>   				next_state = SNK_WAIT_CAPABILITIES;
>   			tcpm_set_state(port, next_state, 0);
>   			break;
> +		case SNK_NEGOTIATE_PPS_CAPABILITIES:
> +			/* Revert data back from any requested PPS updates */
> +			port->pps_data.out_volt = port->supply_voltage;
> +			port->pps_data.op_curr = port->current_limit;
> +			port->pps_status = (type == PD_CTRL_WAIT ?
> +					    -EAGAIN : -EOPNOTSUPP);
> +			tcpm_set_state(port, SNK_READY, 0);
> +			break;
>   		case DR_SWAP_SEND:
>   			port->swap_status = (type == PD_CTRL_WAIT ?
>   					     -EAGAIN : -EOPNOTSUPP);
> @@ -1498,6 +1602,13 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>   	case PD_CTRL_ACCEPT:
>   		switch (port->state) {
>   		case SNK_NEGOTIATE_CAPABILITIES:
> +			port->pps_data.active = false;
> +			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
> +			break;
> +		case SNK_NEGOTIATE_PPS_CAPABILITIES:
> +			port->pps_data.active = true;
> +			port->supply_voltage = port->pps_data.out_volt;
> +			port->current_limit = port->pps_data.op_curr;
>   			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
>   			break;
>   		case SOFT_RESET_SEND:
> @@ -1652,6 +1763,7 @@ static int tcpm_pd_send_control(struct tcpm_port *port,
>   	memset(&msg, 0, sizeof(msg));
>   	msg.header = PD_HEADER_LE(type, port->pwr_role,
>   				  port->data_role,
> +				  port->negotiated_rev,
>   				  port->message_id, 0);
>   
>   	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
> @@ -1761,6 +1873,8 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
>   	unsigned int i, max_mw = 0, max_mv = 0;
>   	int ret = -EINVAL;
>   
> +	port->pps_data.supported = false;
> +
>   	/*
>   	 * Select the source PDO providing the most power while staying within
>   	 * the board's voltage limits. Prefer PDO providing exp
> @@ -1770,20 +1884,41 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
>   		enum pd_pdo_type type = pdo_type(pdo);
>   		unsigned int mv, ma, mw;
>   
> -		if (type == PDO_TYPE_FIXED)
> +		switch (type) {
> +		case PDO_TYPE_FIXED:
>   			mv = pdo_fixed_voltage(pdo);
> -		else
> +			break;
> +		case PDO_TYPE_BATT:
> +		case PDO_TYPE_VAR:
>   			mv = pdo_min_voltage(pdo);
> +			break;
> +		case PDO_TYPE_APDO:
> +			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS)
> +				port->pps_data.supported = true;
> +			continue;
> +		default:
> +			tcpm_log(port, "Invalid PDO type, ignoring");
> +			continue;
> +		}
>   
> -		if (type == PDO_TYPE_BATT) {
> -			mw = pdo_max_power(pdo);
> -		} else {
> +		switch (type) {
> +		case PDO_TYPE_FIXED:
> +		case PDO_TYPE_VAR:
>   			ma = min(pdo_max_current(pdo),
>   				 port->max_snk_ma);
>   			mw = ma * mv / 1000;
> +			break;
> +		case PDO_TYPE_BATT:
> +			mw = pdo_max_power(pdo);
> +			break;
> +		case PDO_TYPE_APDO:
> +			continue;
> +		default:
> +			tcpm_log(port, "Invalid PDO type, ignoring");
> +			continue;
>   		}
>   
> -		/* Perfer higher voltages if available */
> +		/* Prefer higher voltages if available */
>   		if ((mw > max_mw || (mw == max_mw && mv > max_mv)) &&
>   		    mv <= port->max_snk_mv) {
>   			ret = i;
> @@ -1795,6 +1930,65 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
>   	return ret;
>   }
>   
> +static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
> +{
> +	unsigned int i, max_mw = 0, max_mv = 0;
> +	unsigned int pps_min_mv, pps_max_mv, ma, mw;
> +	enum pd_pdo_type type;
> +	u32 pdo;
> +	unsigned int index = 0;
> +
> +	/*
> +	 * Select the source PPS APDO providing the most power while staying
> +	 * within the board's limits. We skip the first PDO as this is always
> +	 * 5V 3A.
> +	 */
> +	for (i = 1; i < port->nr_source_caps; ++i) {
> +		pdo = port->source_caps[i];
> +		type = pdo_type(pdo);
> +
> +		switch (type) {
> +		case PDO_TYPE_APDO:
> +			if (pdo_apdo_type(pdo) != APDO_TYPE_PPS) {
> +				tcpm_log(port, "Not PPS APDO, ignoring");
> +				continue;
> +			}
> +
> +			pps_min_mv = pdo_pps_apdo_min_voltage(pdo);
> +			pps_max_mv = pdo_pps_apdo_max_voltage(pdo);
> +			ma = min(pdo_pps_apdo_max_current(pdo), port->max_snk_ma);
> +			mw = (ma * pps_max_mv) / 1000;
> +			break;
> +		default:
> +			tcpm_log(port, "Not APDO type, ignoring");
> +			continue;
> +		}
> +
> +		/* Prefer higher voltages if available */
> +		if ((mw > max_mw || (mw == max_mw && pps_max_mv > max_mv)) &&
> +		    pps_max_mv <= port->max_snk_mv) {
> +			index = i;
> +			max_mw = mw;
> +			max_mv = pps_max_mv;
> +		}
> +	}
> +
> +	if (index) {
> +		pdo = port->source_caps[index];
> +
> +		port->pps_data.min_volt = pdo_pps_apdo_min_voltage(pdo);
> +		port->pps_data.max_volt = pdo_pps_apdo_max_voltage(pdo);
> +		port->pps_data.max_curr =
> +			min(pdo_pps_apdo_max_current(pdo), port->max_snk_ma);
> +		port->pps_data.out_volt =
> +			min(pdo_pps_apdo_max_voltage(pdo), port->pps_data.out_volt);
> +		port->pps_data.op_curr =
> +			min(pdo_pps_apdo_max_current(pdo), port->pps_data.op_curr);
> +	}
> +
> +	return index;
> +}
> +
>   static int tcpm_pd_build_request(struct tcpm_port *port, u32 *rdo)
>   {
>   	unsigned int mv, ma, mw, flags;
> @@ -1809,10 +2003,18 @@ static int tcpm_pd_build_request(struct tcpm_port *port, u32 *rdo)
>   	pdo = port->source_caps[index];
>   	type = pdo_type(pdo);
>   
> -	if (type == PDO_TYPE_FIXED)
> +	switch (type) {
> +	case PDO_TYPE_FIXED:
>   		mv = pdo_fixed_voltage(pdo);
> -	else
> +		break;
> +	case PDO_TYPE_BATT:
> +	case PDO_TYPE_VAR:
>   		mv = pdo_min_voltage(pdo);
> +		break;
> +	default:
> +		tcpm_log(port, "Invalid PDO selected!");
> +		return -EINVAL;
> +	}
>   
>   	/* Select maximum available current within the board's power limit */
>   	if (type == PDO_TYPE_BATT) {
> @@ -1875,6 +2077,105 @@ static int tcpm_pd_send_request(struct tcpm_port *port)
>   	msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
>   				  port->pwr_role,
>   				  port->data_role,
> +				  port->negotiated_rev,
> +				  port->message_id, 1);
> +	msg.payload[0] = cpu_to_le32(rdo);
> +
> +	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
> +}
> +
> +static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
> +{
> +	unsigned int out_mv, op_ma, op_mw, min_mv, max_mv, max_ma, flags;
> +	enum pd_pdo_type type;
> +	int index;
> +	u32 pdo;
> +
> +	index = tcpm_pd_select_pps_apdo(port);
> +	if (!index)
> +		return -EOPNOTSUPP;
> +
> +	pdo = port->source_caps[index];
> +	type = pdo_type(pdo);
> +
> +	switch (type) {
> +	case PDO_TYPE_APDO:
> +		if (pdo_apdo_type(pdo) != APDO_TYPE_PPS) {
> +			tcpm_log(port, "Invalid APDO selected!");
> +			return -EINVAL;
> +		}
> +		min_mv = port->pps_data.min_volt;
> +		max_mv = port->pps_data.max_volt;
> +		max_ma = port->pps_data.max_curr;
> +		out_mv = port->pps_data.out_volt;
> +		op_ma = port->pps_data.op_curr;
> +		break;
> +	default:
> +		tcpm_log(port, "Invalid PDO selected!");
> +		return -EINVAL;
> +	}
> +
> +	flags = RDO_USB_COMM | RDO_NO_SUSPEND;
> +
> +	op_mw = (op_ma * out_mv) / 1000;
> +	if (op_mw < port->operating_snk_mw) {
> +		/*
> +		 * Try raising current to meet power needs. If that's not enough
> +		 * then try upping the voltage. If that's still not enough
> +		 * then we've obviously chosen a PPS APDO which really isn't
> +		 * suitable so abandon ship.
> +		 */
> +		op_ma = ((port->operating_snk_mw * 1000) / out_mv);
> +		if ((port->operating_snk_mw * 1000) % out_mv)
> +			++op_ma;
> +		op_ma += RDO_PROG_CURR_MA_STEP - (op_ma % RDO_PROG_CURR_MA_STEP);
> +
> +		if (op_ma > max_ma) {
> +			op_ma = max_ma;
> +			out_mv = ((port->operating_snk_mw * 1000) / op_ma);
> +			if ((port->operating_snk_mw * 1000) % op_ma)
> +				++out_mv;
> +			out_mv += RDO_PROG_VOLT_MV_STEP -
> +				  (out_mv % RDO_PROG_VOLT_MV_STEP);
> +
> +			if (out_mv > max_mv) {
> +				tcpm_log(port, "Invalid PPS APDO selected!");
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	tcpm_log(port, "cc=%d cc1=%d cc2=%d vbus=%d vconn=%s polarity=%d",
> +		 port->cc_req, port->cc1, port->cc2, port->vbus_source,
> +		 port->vconn_role == TYPEC_SOURCE ? "source" : "sink",
> +		 port->polarity);
> +
> +	*rdo = RDO_PROG(index + 1, out_mv, op_ma, flags);
> +
> +	tcpm_log(port, "Requesting APDO %d: %u mV, %u mA",
> +		 index, out_mv, op_ma);
> +
> +	port->pps_data.op_curr = op_ma;
> +	port->pps_data.out_volt = out_mv;
> +
> +	return 0;
> +}
> +
> +static int tcpm_pd_send_pps_request(struct tcpm_port *port)
> +{
> +	struct pd_message msg;
> +	int ret;
> +	u32 rdo;
> +
> +	ret = tcpm_pd_build_pps_request(port, &rdo);
> +	if (ret < 0)
> +		return ret;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
> +				  port->pwr_role,
> +				  port->data_role,
> +				  port->negotiated_rev,
>   				  port->message_id, 1);
>   	msg.payload[0] = cpu_to_le32(rdo);
>   
> @@ -2060,6 +2361,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
>   	tcpm_typec_disconnect(port);
>   	port->attached = false;
>   	port->pd_capable = false;
> +	port->pps_data.supported = false;
>   
>   	/*
>   	 * First Rx ID should be 0; set this to a sentinel of -1 so that
> @@ -2075,6 +2377,8 @@ static void tcpm_reset_port(struct tcpm_port *port)
>   	tcpm_set_attached_state(port, false);
>   	port->try_src_count = 0;
>   	port->try_snk_count = 0;
> +	port->supply_voltage = 0;
> +	port->current_limit = 0;
>   }
>   
>   static void tcpm_detach(struct tcpm_port *port)
> @@ -2321,6 +2625,7 @@ static void run_state_machine(struct tcpm_port *port)
>   		typec_set_pwr_opmode(port->typec_port, opmode);
>   		port->pwr_opmode = TYPEC_PWR_MODE_USB;
>   		port->caps_count = 0;
> +		port->negotiated_rev = PD_MAX_REV;
>   		port->message_id = 0;
>   		port->rx_msgid = -1;
>   		port->explicit_contract = false;
> @@ -2381,6 +2686,7 @@ static void run_state_machine(struct tcpm_port *port)
>   
>   		tcpm_swap_complete(port, 0);
>   		tcpm_typec_connect(port);
> +
>   		tcpm_check_send_discover(port);
>   		/*
>   		 * 6.3.5
> @@ -2404,6 +2710,7 @@ static void run_state_machine(struct tcpm_port *port)
>   	case SNK_UNATTACHED:
>   		if (!port->non_pd_role_swap)
>   			tcpm_swap_complete(port, -ENOTCONN);
> +		tcpm_pps_complete(port, -ENOTCONN);
>   		tcpm_snk_detach(port);
>   		if (tcpm_start_drp_toggling(port)) {
>   			tcpm_set_state(port, DRP_TOGGLING, 0);
> @@ -2412,6 +2719,7 @@ static void run_state_machine(struct tcpm_port *port)
>   		tcpm_set_cc(port, TYPEC_CC_RD);
>   		if (port->port_type == TYPEC_PORT_DRP)
>   			tcpm_set_state(port, SRC_UNATTACHED, PD_T_DRP_SRC);
> +
>   		break;
>   	case SNK_ATTACH_WAIT:
>   		if ((port->cc1 == TYPEC_CC_OPEN &&
> @@ -2493,6 +2801,7 @@ static void run_state_machine(struct tcpm_port *port)
>   					      port->cc2 : port->cc1);
>   		typec_set_pwr_opmode(port->typec_port, opmode);
>   		port->pwr_opmode = TYPEC_PWR_MODE_USB;
> +		port->negotiated_rev = PD_MAX_REV;
>   		port->message_id = 0;
>   		port->rx_msgid = -1;
>   		port->explicit_contract = false;
> @@ -2563,6 +2872,24 @@ static void run_state_machine(struct tcpm_port *port)
>   					    PD_T_SENDER_RESPONSE);
>   		}
>   		break;
> +	case SNK_NEGOTIATE_PPS_CAPABILITIES:
> +		ret = tcpm_pd_send_pps_request(port);
> +		if (ret < 0) {
> +			port->pps_status = ret;
> +			/*
> +			 * If this was called due to updates to sink
> +			 * capabilities, and pps is no longer valid, we should
> +			 * safely fall back to a standard PDO.
> +			 */
> +			if (port->update_sink_caps)
> +				tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
> +			else
> +				tcpm_set_state(port, SNK_READY, 0);
> +		} else {
> +			tcpm_set_state_cond(port, hard_reset_state(port),
> +					    PD_T_SENDER_RESPONSE);
> +		}
> +		break;
>   	case SNK_TRANSITION_SINK:
>   	case SNK_TRANSITION_SINK_VBUS:
>   		tcpm_set_state(port, hard_reset_state(port),
> @@ -2570,6 +2897,7 @@ static void run_state_machine(struct tcpm_port *port)
>   		break;
>   	case SNK_READY:
>   		port->try_snk_count = 0;
> +		port->update_sink_caps = false;
>   		if (port->explicit_contract) {
>   			typec_set_pwr_opmode(port->typec_port,
>   					     TYPEC_PWR_MODE_PD);
> @@ -2578,7 +2906,11 @@ static void run_state_machine(struct tcpm_port *port)
>   
>   		tcpm_swap_complete(port, 0);
>   		tcpm_typec_connect(port);
> +
>   		tcpm_check_send_discover(port);
> +
> +		tcpm_pps_complete(port, port->pps_status);
> +
>   		break;
>   
>   	/* Accessory states */
> @@ -2625,6 +2957,7 @@ static void run_state_machine(struct tcpm_port *port)
>   		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
>   		break;
>   	case SNK_HARD_RESET_SINK_OFF:
> +		memset(&port->pps_data, 0, sizeof(port->pps_data));
>   		tcpm_set_vconn(port, false);
>   		tcpm_set_charge(port, false);
>   		tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
> @@ -2845,6 +3178,7 @@ static void run_state_machine(struct tcpm_port *port)
>   		break;
>   	case ERROR_RECOVERY:
>   		tcpm_swap_complete(port, -EPROTO);
> +		tcpm_pps_complete(port, -EPROTO);
>   		tcpm_set_state(port, PORT_RESET, 0);
>   		break;
>   	case PORT_RESET:
> @@ -3310,7 +3644,7 @@ static int tcpm_dr_set(const struct typec_capability *cap,
>   	mutex_unlock(&port->lock);
>   
>   	if (!wait_for_completion_timeout(&port->swap_complete,
> -				msecs_to_jiffies(PD_ROLE_SWAP_TIMEOUT)))
> +				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
>   		ret = -ETIMEDOUT;
>   	else
>   		ret = port->swap_status;
> @@ -3355,7 +3689,7 @@ static int tcpm_pr_set(const struct typec_capability *cap,
>   	mutex_unlock(&port->lock);
>   
>   	if (!wait_for_completion_timeout(&port->swap_complete,
> -				msecs_to_jiffies(PD_ROLE_SWAP_TIMEOUT)))
> +				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
>   		ret = -ETIMEDOUT;
>   	else
>   		ret = port->swap_status;
> @@ -3395,7 +3729,7 @@ static int tcpm_vconn_set(const struct typec_capability *cap,
>   	mutex_unlock(&port->lock);
>   
>   	if (!wait_for_completion_timeout(&port->swap_complete,
> -				msecs_to_jiffies(PD_ROLE_SWAP_TIMEOUT)))
> +				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
>   		ret = -ETIMEDOUT;
>   	else
>   		ret = port->swap_status;
> @@ -3427,6 +3761,162 @@ static int tcpm_try_role(const struct typec_capability *cap, int role)
>   	return ret;
>   }
>   
> +static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
> +{
> +	unsigned int target_mw;
> +	int ret = 0;
> +

Unnecessary initialization.

> +	mutex_lock(&port->swap_lock);
> +	mutex_lock(&port->lock);
> +
> +	if (!port->pps_data.active) {
> +		ret = -EOPNOTSUPP;
> +		goto port_unlock;
> +	}
> +
> +	if (port->state != SNK_READY) {
> +		ret = -EAGAIN;
> +		goto port_unlock;
> +	}
> +
> +	if (op_curr > port->pps_data.max_curr) {
> +		ret = -EINVAL;
> +		goto port_unlock;
> +	}
> +
> +	target_mw = (op_curr * port->pps_data.out_volt) / 1000;
> +	if (target_mw < port->operating_snk_mw) {
> +		ret = -EINVAL;
> +		goto port_unlock;
> +	}
> +
> +	reinit_completion(&port->pps_complete);
> +	port->pps_data.op_curr = op_curr;
> +	port->pps_status = 0;
> +	port->pps_pending = true;
> +	tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
> +	mutex_unlock(&port->lock);
> +
> +	if (!wait_for_completion_timeout(&port->pps_complete,
> +				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
> +		ret = -ETIMEDOUT;
> +	else
> +		ret = port->pps_status;
> +
> +	goto swap_unlock;
> +
> +port_unlock:
> +	mutex_unlock(&port->lock);
> +swap_unlock:
> +	mutex_unlock(&port->swap_lock);
> +
> +	return ret;
> +}
> +
> +static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
> +{
> +	unsigned int target_mw;
> +	int ret = 0;
> +
Unnecessary initialization.

> +	mutex_lock(&port->swap_lock);
> +	mutex_lock(&port->lock);
> +
> +	if (!port->pps_data.active) {
> +		ret = -EOPNOTSUPP;
> +		goto port_unlock;
> +	}
> +
> +	if (port->state != SNK_READY) {
> +		ret = -EAGAIN;
> +		goto port_unlock;
> +	}
> +
> +	if ((out_volt < port->pps_data.min_volt) ||
> +	    (out_volt > port->pps_data.max_volt)) {

Unnecessary ( )

> +		ret = -EINVAL;
> +		goto port_unlock;
> +	}
> +
> +	target_mw = (port->pps_data.op_curr * out_volt) / 1000;
> +	if (target_mw < port->operating_snk_mw) {
> +		ret = -EINVAL;
> +		goto port_unlock;
> +	}
> +
> +	reinit_completion(&port->pps_complete);
> +	port->pps_data.out_volt = out_volt;
> +	port->pps_status = 0;
> +	port->pps_pending = true;
> +	tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
> +	mutex_unlock(&port->lock);
> +
> +	if (!wait_for_completion_timeout(&port->pps_complete,
> +				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
> +		ret = -ETIMEDOUT;
> +	else
> +		ret = port->pps_status;
> +
> +	goto swap_unlock;
> +
> +port_unlock:
> +	mutex_unlock(&port->lock);
> +swap_unlock:
> +	mutex_unlock(&port->swap_lock);
> +
> +	return ret;
> +}
> +
> +static int tcpm_pps_activate(struct tcpm_port *port, bool activate)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&port->swap_lock);
> +	mutex_lock(&port->lock);
> +
> +	if (!port->pps_data.supported) {
> +		ret = -EOPNOTSUPP;
> +		goto port_unlock;
> +	}
> +
> +	/* Trying to deactivate PPS when already deactivated so just bail */
> +	if ((!port->pps_data.active) && (!activate))

Unnecessary ( )

> +		goto port_unlock;
> +
> +	if (port->state != SNK_READY) {
> +		ret = -EAGAIN;
> +		goto port_unlock;
> +	}
> +
> +	reinit_completion(&port->pps_complete);
> +	port->pps_status = 0;
> +	port->pps_pending = true;
> +
> +	/* Trigger PPS request or move back to standard PDO contract */
> +	if (activate) {
> +		port->pps_data.out_volt = port->supply_voltage;
> +		port->pps_data.op_curr = port->current_limit;
> +		tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
> +	} else {
> +		tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
> +	}
> +	mutex_unlock(&port->lock);
> +
> +	if (!wait_for_completion_timeout(&port->pps_complete,
> +				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
> +		ret = -ETIMEDOUT;
> +	else
> +		ret = port->pps_status;
> +
> +	goto swap_unlock;
> +
> +port_unlock:
> +	mutex_unlock(&port->lock);
> +swap_unlock:
> +	mutex_unlock(&port->swap_lock);
> +
> +	return ret;
> +}
> +
>   static void tcpm_init(struct tcpm_port *port)
>   {
>   	enum typec_cc_status cc1, cc2;
> @@ -3566,13 +4056,18 @@ int tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
>   	port->max_snk_ma = max_snk_ma;
>   	port->max_snk_mw = max_snk_mw;
>   	port->operating_snk_mw = operating_snk_mw;
> +	port->update_sink_caps = true;
>   
>   	switch (port->state) {
>   	case SNK_NEGOTIATE_CAPABILITIES:
> +	case SNK_NEGOTIATE_PPS_CAPABILITIES:
>   	case SNK_READY:
>   	case SNK_TRANSITION_SINK:
>   	case SNK_TRANSITION_SINK_VBUS:
> -		tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
> +		if (port->pps_data.active)
> +			tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
> +		else
> +			tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
>   		break;
>   	default:
>   		break;
> @@ -3614,6 +4109,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>   
>   	init_completion(&port->tx_complete);
>   	init_completion(&port->swap_complete);
> +	init_completion(&port->pps_complete);
>   	tcpm_debugfs_init(port);
>   
>   	if (tcpm_validate_caps(port, tcpc->config->src_pdo,
> @@ -3642,7 +4138,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>   	port->typec_caps.prefer_role = tcpc->config->default_role;
>   	port->typec_caps.type = tcpc->config->type;
>   	port->typec_caps.revision = 0x0120;	/* Type-C spec release 1.2 */
> -	port->typec_caps.pd_revision = 0x0200;	/* USB-PD spec release 2.0 */
> +	port->typec_caps.pd_revision = 0x0300;	/* USB-PD spec release 3.0 */
>   	port->typec_caps.dr_set = tcpm_dr_set;
>   	port->typec_caps.pr_set = tcpm_pr_set;
>   	port->typec_caps.vconn_set = tcpm_vconn_set;
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index ff359bdf..09b570f 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -103,8 +103,8 @@ enum pd_ext_msg_type {
>   	 (((cnt) & PD_HEADER_CNT_MASK) << PD_HEADER_CNT_SHIFT) |	\
>   	 ((ext_hdr) ? PD_HEADER_EXT_HDR : 0))
>   
> -#define PD_HEADER_LE(type, pwr, data, id, cnt) \
> -	cpu_to_le16(PD_HEADER((type), (pwr), (data), PD_REV20, (id), (cnt), (0)))
> +#define PD_HEADER_LE(type, pwr, data, rev, id, cnt) \
> +	cpu_to_le16(PD_HEADER((type), (pwr), (data), (rev), (id), (cnt), (0)))
>   
>   static inline unsigned int pd_header_cnt(u16 header)
>   {
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index ca1c0b5..d6673f7 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -35,7 +35,7 @@ enum typec_cc_polarity {
>   
>   /* Time to wait for TCPC to complete transmit */
>   #define PD_T_TCPC_TX_TIMEOUT	100		/* in ms	*/
> -#define PD_ROLE_SWAP_TIMEOUT	(MSEC_PER_SEC * 10)
> +#define PD_STATE_MACHINE_TIMEOUT	(MSEC_PER_SEC * 10)
>   
>   enum tcpm_transmit_status {
>   	TCPC_TX_SUCCESS = 0,
> 
